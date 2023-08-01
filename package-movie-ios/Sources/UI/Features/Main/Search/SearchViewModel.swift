//
//  SearchViewModel.swift
//  
//
//  Created by Hải Lưu on 24/06/2023.
//

import Foundation
import Common
import Domain
import DependencyKit
import Combine

public enum SearchStep: Step {
    case goDetail(idMovie: Int)
}

public enum SearchAction {
    case loadMoviesInit
    case goDetail(idMovie: Int)
    case searchMovie
}


public class SearchViewModel: ViewModel {
    
    @Injected(Container.searchMovieUsecase) var searchMovieUsecase
    
    @Published var step: SearchStep?
    
    @Published var searchKey: String = ""
    
    @Published var movies: [Movie] = []
    @Published var isLoading: Bool = false
    @Published var isFirstLoad: Bool = true
    
    @Published var searchError: String?
    
    var myCancellable = Set<AnyCancellable>()
    
    public init() {
        errorHandler.receiveError(Error.self).sink { error in
            self.searchError = error.localizedDescription
        }
        .store(in: &errorHandler.cancellables)
        
        //Delay search for each keyword
        $searchKey.debounce(for: 0.5, scheduler: RunLoop.main) .sink {value in
            if !value.isEmpty {
                self.dispatch(action: .searchMovie)
            }
        }
        .store(in: &myCancellable)
    }
    
    public func dispatch(action: SearchAction) {
        switch action {
        case let .goDetail(id):
            step = .goDetail(idMovie: id)
        case .loadMoviesInit:
            getListMovieByKeywords(keywords: searchKey, page: 1)
        case .searchMovie:
            getListMovieByKeywords(keywords: searchKey, page: 1)
        }
    }
    
    func getListMovieByKeywords(keywords: String, page: Int) -> Void {
        isFirstLoad = false
        isLoading = true
        searchError = nil
        asyncTask.cancel()
        asyncTask { @MainActor [self] in
            let data = try await searchMovieUsecase.callAsFunction((keyword: keywords, page: page))
            movies = data
            isLoading = false
        } onFinished: {
            self.isLoading = false
        }
    }
}


