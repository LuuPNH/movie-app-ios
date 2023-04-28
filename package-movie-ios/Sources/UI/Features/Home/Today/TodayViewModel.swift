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
    case today
    case detail
}

public enum TodayAction {}

public class TodayViewModel: ObservableObject {
    
    @Injected(Container.theMovieDBService) var theMovieDBService
    
    @Published var step: TodayStep = .today
    
    @Published var movies: [Movie] = []
    @Published var isLoading: Bool = true
    
    public init() {
        getListMovie()
    }
    
    public func dispatch(action: TodayAction) {
        
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
