//
//  CategoriesViewModel.swift
//  
//
//  Created by Luu Phan on 24/03/2023.
//

import Foundation
import DependencyKit
import Domain
import Common

public enum CategoriesStep: Step {
    case categories
    case detail
}

public enum CategoriesAction {
    case getList
}

public class CategoriesViewModel: ViewModel {
    
    @Published var step: CategoriesStep = .categories
    
    @Injected(Container.categoriesUseCase) var categoriesUseCase
    
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
    
    func getListMovie(_ tab: CategoriesMovie) async throws -> [Movie] {
        let data = try await categoriesUseCase.callAsFunction((page: 1, type: tab))
        return data
    }
    
    func updateMovies(_ tab: CategoriesMovie) {
        asyncTask { @MainActor [self] in
            let findItem = tuples.firstIndex { $0.type == tab }
            if(tuples[findItem!].movies.isEmpty) {
                let movies = try await getListMovie(tab);
                tuples[findItem!] = tuples[findItem!].copyWith(movies: movies, isLoading: false)
            }
            selectItem = tuples[findItem!]
        }
    }
}
