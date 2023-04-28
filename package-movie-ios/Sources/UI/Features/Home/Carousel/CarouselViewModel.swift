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
    case carousel
    case detail
}

public enum CarouselAction {
    case getlist
}

public class CarouselViewModel: ViewModel {
    
    @Published var step: CarouselStep = .carousel
    
    @Injected(Container.carouselUseCase) var carouselUseCase
    
    private var cancellables: [AnyCancellable] = []
    
    @Published var listImageMovie: [Movie] = []
    
    public init() {
        
    }
    
    public func dispatch(action: CarouselAction) {
        switch action {
        case .getlist:
            getlistNowplaying()
        }
    }
    func getlistNowplaying() {
        asyncTask { @MainActor [self] in
            let data = try await carouselUseCase()
            listImageMovie = data
        }
    }
}
