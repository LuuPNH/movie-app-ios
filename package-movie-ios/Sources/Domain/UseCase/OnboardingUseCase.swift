//
//  File.swift
//  
//
//  Created by Luu Phan on 13/02/2023.
//

import Foundation
import DependencyKit

public class OnboardingUseCase: AsyncUseCase {
    @Injected(Container.onboardingService) var onboardingService
    
    public func callAsFunction(_ input: Void) -> ShowOnboarding {
        return onboardingService.checkShowOnboarding()
    }
    
    public typealias Input = Void
    
    public typealias Output = ShowOnboarding
    
}
