//
//  CategoriesViewModel.swift
//  
//
//  Created by Luu Phan on 24/03/2023.
//

import Foundation
import DependencyKit
import Domain


public enum CategoriesAction {
    case getList
}

public class CategoriesViewModel: ObservableObject {
    
    @Injected(Container.theMovieDBService) var theMovieDBService
    
    
    @Published var tuples: [ItemCategoriesMovie]
    
    @Published var selectItem: ItemCategoriesMovie
    
    public init() {
        self.tuples = CategoriesMovie.allCases.map { ItemCategoriesMovie(type: $0, movies: [],isLoading: true) }
        self.selectItem = ItemCategoriesMovie(type: .nowPlaying, movies: [], isLoading: true)
        goTab(.nowPlaying)
    }
    
    public func dispatch(action: CategoriesAction) {
        switch action {
        case .getList:
            return
        }
    }
    
    public func goTab(_ tab: CategoriesMovie) {
        let item =  tuples.first { $0.type == tab }
        selectItem = item!
        updateMovies(tab)
    }
    
    func getListMovie(_ tab: CategoriesMovie) async -> [Movie] {
        do {
            let data = try await theMovieDBService.getListMovie(page: 1, type: tab)
            return data
        } catch {
            return []
        }
    }
    
    func updateMovies(_ tab: CategoriesMovie) {
        Task { @MainActor in
            let findItem = tuples.firstIndex { $0.type == tab }
            if(tuples[findItem!].movies.isEmpty) {
                let newList = await getListMovie(tab)
                tuples[findItem!] = tuples[findItem!].copyWith(movies: newList, isLoading: false)
            }
            selectItem = tuples[findItem!]
        }
    }
}
