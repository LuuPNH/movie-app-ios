//
//  File.swift
//  
//
//  Created by Luu Phan on 16/02/2023.
//

import Foundation
import Common
import Domain
import DependencyKit

public class SplashViewModel: ViewModel {
    
    public enum Action {
        case goHome
        case checkShowOnboarding
    }
    
    @Injected(Container.showOnboardingUseCase) var showOnboardingUseCase
    
    @Published var nextStep: SplashStep?
    
    deinit {
        dLog("+++++ SplashViewModel deinit +++++")
    }
    
    public func dispatch(action: Action) {
        switch action {
        case .goHome:
            nextStep = .main
        case .checkShowOnboarding:
            checkShowOnboarding()
        }
    }
    
    func checkShowOnboarding() {
        Task { @MainActor in
            let data = try await showOnboardingUseCase.callAsFunction()
            switch data {
            case .isShowedOnboarding:
                nextStep = .main
            case .unShowed:
                nextStep = .onboard
            }
        }
    }
}

