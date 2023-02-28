//
//  File.swift
//  
//
//  Created by Luu Phan on 13/02/2023.
//

import Foundation
import Domain
import DependencyKit

public class OnboardingServiceImpl: OnboardingService {
    
    @Injected(Container.userDefaults) var userDefaults
    
    public func getStartedApp() -> ShowOnboarding {
        userDefaults.onboarding = .isShowedOnboarding
        return .isShowedOnboarding
    }
    
    public func checkShowOnboarding() -> ShowOnboarding {
        return userDefaults.onboarding ?? .unShowed
    }
}
