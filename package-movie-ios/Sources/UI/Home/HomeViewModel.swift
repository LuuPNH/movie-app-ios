//
//  HomeViewModel.swift
//  
//
//  Created by Luu Phan on 28/02/2023.
//

import Foundation
import Common

public enum HomeTab {
    case trend
    case favorite
}

public enum HomeStep: Step {
    case home
    case detail
}

public enum HomeAction {
    case goTab
}

public class HomeViewModel: ObservableObject {
    
    @Published var homeTab: HomeTab?
    
    public init() {
        homeTab = .trend
    }
    
    public func dispatch(action: HomeAction) {
        switch action {
        case .goTab:
            homeTab = .trend
        }
    }

}
