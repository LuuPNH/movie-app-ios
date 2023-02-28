//
//  File.swift
//  
//
//  Created by Luu Phan on 13/02/2023.
//

import Foundation
import Common
import DependencyKit


public enum OnboardingStep: Step {
    case goHome
}

public class OnboardingViewModel: ObservableObject {
    
    public enum Action {
        case goHome
    }
    
    @Published var nextStep: OnboardingStep?
    
    @Injected(Container.getStartedAppUseCase) var getStartedAppUseCase
    
    public init() {
    }
    
    public func dispatch(action: Action) {
        switch action {
        case .goHome:
            checkShowOnboarding()
        }
    }
    
    func checkShowOnboarding() {
        Task { @MainActor in
            let data = try await getStartedAppUseCase.callAsFunction()
            switch data {
            case .isShowedOnboarding:
                nextStep = .goHome
            case .unShowed:
                break
            }
        }
    }
        
}
