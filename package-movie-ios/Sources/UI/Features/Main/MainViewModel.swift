//
//  MainViewModel.swift
//  
//
//  Created by Luu Phan on 09/05/2023.
//

import Foundation
import Common
import DependencyKit

public enum MainAction {
    case runApp
    case goDetailMovie
    case switchTab(tab: AppTab)
}

public enum MainStep: Step {
    case home
    case detailMovie
}

public enum AppTab: CaseIterable {
    case home
    case search
    case download
    case profile
}

public class MainViewModel: ViewModel {
    
    @Published var appTab: AppTab = .home
    
    public init() {}
    
    public func dispatch(action: MainAction) {
        switch action {
        case .runApp:
            return
        case .goDetailMovie:
            return
        case let .switchTab(tab):
            appTab = tab
        }
    }
}

