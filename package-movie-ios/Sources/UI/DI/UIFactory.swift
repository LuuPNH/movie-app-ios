//
//  File.swift
//  
//
//  Created by Luu Phan on 10/01/2023.
//

import Foundation
import DependencyKit
import Domain

public extension Container {
    
    static let authenticationViewModel = Factory {
        AuthenticationViewModel()
    }
    
    static let splashViewModel = Factory {
        SplashViewModel()
    }
    
    static let showOnboardingViewModel = Factory {
        OnboardingViewModel()
    }
    
    static let homeViewModel = Factory {
        HomeViewModel()
    }
    
    static let carouselViewModel = Factory {
        CarouselViewModel()
    }
}
