//
//  CarouselViewModel.swift
//  
//
//  Created by Luu Phan on 01/03/2023.
//

import Foundation
import DependencyKit
import Domain

public enum CarouselAction {
    case getlist
}

public class CarouselViewModel: ObservableObject {
    
    @Injected(Container.carouselService) var carouselService
    
    @Published var listNowplaying: [Movie] = []
    
    public init() {}
    
    public func dispatch(action: CarouselAction) {
        switch action {
        case .getlist:
            getlistNowplaying()
        }
    }

    func getlistNowplaying() {
        Task { @MainActor in
            let data = try await carouselService.getListCarousel(page: 1)
        }
    }
}
