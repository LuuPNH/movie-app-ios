//
//  CarouselViewModel.swift
//  
//
//  Created by Luu Phan on 01/03/2023.
//

import Foundation
import DependencyKit
import Domain
import Combine
import SwiftUI
import Common

public enum CarouselStep: Step {
    case goDetail(idMovie: Int)
}

public enum CarouselAction {
    case getlist
    case goDetail(idMovie: Int)
}

public class CarouselViewModel: ViewModel {
    
    @Published var step: CarouselStep?
    
    @Injected(Container.carouselUseCase) var carouselUseCase
    
    private var cancellables: [AnyCancellable] = []
    
    @Published var listImageMovie: [Movie] = []
    
    public init() {
        dispatch(action: .getlist)
    }
    
    public func dispatch(action: CarouselAction) {
        switch action {
        case .getlist:
            getlistNowplaying()
        case let .goDetail(id):
            step = .goDetail(idMovie: id)
        }
    }
    func getlistNowplaying() {
        asyncTask { @MainActor [self] in
            let data = try await carouselUseCase()
            listImageMovie = data
        }
    }
}
