//
//  HomeViewModel.swift
//  
//
//  Created by Luu Phan on 28/02/2023.
//

import Foundation
import Common

public enum HomeStep: Step {
    case home
    case goDetail(idMovie: Int)
}

public enum HomeAction {
    case home
    case goDetail(idMovie: Int)
}

public class HomeViewModel: ObservableObject {
    
    @Published var step: HomeStep = .home
    
    public init() {}
    
    public func dispatch(action: HomeAction) {
        switch action {
        case .home:
            return
        case let .goDetail(id):
            step = .goDetail(idMovie: id)
        }
    }
}
