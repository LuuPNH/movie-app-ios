//
//  File.swift
//  
//
//  Created by Luu Phan on 10/01/2023.
//

import Foundation
import Domain
import DependencyKit
import Moya

extension Container {
    
    static let network = Factory(scope: .shared) {
            Network(plugins: [
                MoyaProvider<MultiTarget>.defaultNetworkLoggerPlugin(),
                AuthenticationPlugin()
            ]) as Networking
        }
    
}

public class DataFactory: DataProvider, EnvironmentProvider {
    
    public var configurationEnvironment: Environment {
        ConfigurationEnvironment(mode: .development)
    }
    
    
    public var theMovieDBService: TheMovieDBService {
        TheMovieDBSeverviceImpl()
    }
    
    public var userDefaultsService: KeyValue {
        KeyValueStore.shared
    }
    
    public var onboardingService: OnboardingService {
        OnboardingServiceImpl()
    }
    
    public var authenticationService: AuthenticationService {
        AuthenticationServiceImpl()
    }
    
    public init() {}
}
