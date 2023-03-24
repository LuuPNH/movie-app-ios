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

public enum CarouselAction {
    case getlist
}

public class CarouselViewModel: ObservableObject {
    
    @Injected(Container.carouselService) var carouselService
    @Published private(set) var stateModel: UIStateModel = UIStateModel()
    @Published private(set) var activeCard: Int = 0
    private var cancellables: [AnyCancellable] = []
    
    @Published var listImageMovie: [Movie] = []
    
    public init() {}
    
    private func someCoolMethodHere(for activeCard: Int) {
            print("someCoolMethodHere: index received: ", activeCard)
            self.activeCard = activeCard
        }
    
    public func dispatch(action: CarouselAction) {
        switch action {
        case .getlist:
            getlistNowplaying()
        }
        
    }

    func getlistNowplaying() {
        Task { @MainActor in
            let data = try await carouselService.getListCarousel(page: 1)
            listImageMovie = data
        }
    }
}
