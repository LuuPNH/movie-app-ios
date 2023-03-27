//
//  HomeViewModel.swift
//  
//
//  Created by Luu Phan on 28/02/2023.
//

import Foundation
import Common

public enum HomeTab {
    case home
    case search
    case download
    case profile
}

public enum HomeStep: Step {
    case home
    case detail
}

public enum HomeAction {
    case goTab
}

public class HomeViewModel: ObservableObject {
    
    @Published var homeTab: HomeTab
    
    public init() {
        homeTab = .home
    }
    
    public func dispatch(action: HomeAction) {
        
    }
    public func goTab(tab: HomeTab) {
        homeTab = tab
    }
}
