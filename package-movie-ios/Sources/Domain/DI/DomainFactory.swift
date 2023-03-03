//
//  File.swift
//  
//
//  Created by Luu Phan on 10/01/2023.
//

import Foundation
import DependencyKit

extension Container {
    
    public static let authenticationUseCase = Factory {
        AuthenticateUseCase()
    }
    
    public static let showOnboardingUseCase = Factory {
        OnboardingUseCase()
    }
    
    public static let getStartedAppUseCase = Factory {
        GetStratedAppUseCase()
    }
    
    public static let carouselUseCase = Factory {
        CarouselUseCase()
    }
}
