//
//  DetailViewModel.swift
//  
//
//  Created by Luu Phan on 08/05/2023.
//

import Foundation
import Common
import Domain
import DependencyKit

public enum DetailAction {
    case getInfoMovie
    case getInfoVideoMovie
}

public enum DetailStep: Step {
    case goDetail
    case goWatchMovie
}

public class DetailViewModel: ViewModel {
    
    @Injected(Container.detailUseCase) var detailUseCase
    @Injected(Container.videoMovieUseCase) var videoMovieUseCase
    
    @Published var step: DetailStep = .goDetail
    
    @Published var movie: Movie? = nil
    
    @Published var videoMovie: VideoMovie? = nil
    
    @Published var isLoading: Bool = false
    
    @Published var isLoadingVideo: Bool = false
    
    let idMovie: Int
    
    public init(idMovie: Int) {
        self.idMovie = idMovie
        disPatch(action: .getInfoMovie)
    }
    
    func disPatch(action: DetailAction) {
        switch action {
        case .getInfoMovie:
            getInfoMovie()
            step = .goDetail
        case .getInfoVideoMovie:
            getVideoMovie()
            step = .goWatchMovie	
        }
        
        func getInfoMovie() {
            asyncTask { @MainActor [self] in
                isLoading = true
                let data = try await detailUseCase.callAsFunction(idMovie)
                movie = data
            } onFinished: {
                self.isLoading = false
            }
        }
        
        func getVideoMovie() {
            asyncTask { @MainActor [self] in
                isLoadingVideo = true
                let data = try await videoMovieUseCase.callAsFunction(idMovie)
                videoMovie = data
            } onFinished: {
                self.isLoadingVideo = false
            }
        }
    }
}
