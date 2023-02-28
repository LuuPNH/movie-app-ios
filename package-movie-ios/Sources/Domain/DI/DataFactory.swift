//
//  File.swift
//  
//
//  Created by Luu Phan on 10/01/2023.
//

import Foundation
import DependencyKit

public extension Container {
    static var dataProvider: DataProvider!
    
    static let userDefaults = Factory(scope: .singleton) { dataProvider.userDefaultsService }
    static let onboardingService = Factory(scope: .singleton) { dataProvider.onboardingService }
    static let authenticationService = Factory { dataProvider.authenticationService }
    
}


public protocol DataProvider {
    var userDefaultsService: KeyValue { get }
    var onboardingService: OnboardingService { get }
    var authenticationService: AuthenticationService { get }
}
