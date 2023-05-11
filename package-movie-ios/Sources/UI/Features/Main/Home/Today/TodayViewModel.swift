//
//  TodayViewModel.swift
//  
//
//  Created by Luu Phan on 12/04/2023.
//

import Foundation
import Domain
import DependencyKit
import Common

public enum TodayStep: Step {
    case goDetail(idMovie: Int)
}

public enum TodayAction {
    case getlistMovie
    case goDetail(idMovie: Int)
}

public class TodayViewModel: ViewModel {
    
    @Injected(Container.theMovieDBService) var theMovieDBService
    
    @Published var step: TodayStep?
    
    @Published var movies: [Movie] = []
    @Published var isLoading: Bool = true
    
    public init() {
        dispatch(action: .getlistMovie)
    }
    
    public func dispatch(action: TodayAction) {
        switch action {
        case .getlistMovie:
            getListMovie()
        case let .goDetail(idMovie):
            step = .goDetail(idMovie: idMovie)
        }
    }
    
    func getListMovie() {
        isLoading = true
        Task { @MainActor in
            let data = try await theMovieDBService.getTrendingMovies()
            movies = data
            isLoading = false
        }
    }
}
