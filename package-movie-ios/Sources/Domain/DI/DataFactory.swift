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
    
    static let configurationEnvironment = Factory(scope: .singleton) { dataProvider.configurationEnvironment }
    
    static let userDefaults = Factory(scope: .singleton) { dataProvider.userDefaultsService }
    static let onboardingService = Factory(scope: .singleton) { dataProvider.onboardingService }
    static let authenticationService = Factory { dataProvider.authenticationService }
    static let theMovieDBService = Factory { dataProvider.theMovieDBService }
    
}


public protocol DataProvider {
    
    var configurationEnvironment: Environment { get }
    
    var userDefaultsService: KeyValue { get }
    var onboardingService: OnboardingService { get }
    var authenticationService: AuthenticationService { get }
    var theMovieDBService: TheMovieDBService { get }
}
