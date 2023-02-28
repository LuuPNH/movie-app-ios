//
//  GetStratedAppUseCase.swift
//  
//
//  Created by Luu Phan on 28/02/2023.
//

import Foundation
import DependencyKit

public class GetStratedAppUseCase: AsyncUseCase {
    @Injected(Container.onboardingService) var onboardingService
    
    public func callAsFunction(_ input: Void) -> ShowOnboarding {
        return onboardingService.getStartedApp()
    }
    
    public typealias Input = Void
    
    public typealias Output = ShowOnboarding
    
}
