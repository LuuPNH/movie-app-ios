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
    
    @Injected(Container.theMovieDBService) var theMovieDBService
    
    private var cancellables: [AnyCancellable] = []
    
    @Published var listImageMovie: [Movie] = []
    
    public init() {}
    
    public func dispatch(action: CarouselAction) {
        switch action {
        case .getlist:
            getlistNowplaying()
        }
        
    }

    func getlistNowplaying() {
        Task { @MainActor in
            let data = try await theMovieDBService.getListMovie(page: 1, type: .nowPlaying)
            listImageMovie = data
        }
    }
}
