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
    case error
}

public enum DetailStep: Step {
    case goDetail
}

public class DetailViewModel: ViewModel {
    
    @Injected(Container.detailUseCase) var detailUseCase
    
    @Published var step: DetailStep = .goDetail
    
    @Published var movie: Movie? = nil
    
    @Published var isLoading: Bool = false
    
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
        case .error:
            movie = nil
        }
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
}
