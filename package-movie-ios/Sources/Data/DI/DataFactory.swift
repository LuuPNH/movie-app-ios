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

public class DataFactory: DataProvider {
    
    public var carouselService: Domain.CarouselService {
        CarouselSeverviceImpl()
    }
    
    public var userDefaultsService: Domain.KeyValue {
        KeyValueStore.shared
    }
    
    public var onboardingService: Domain.OnboardingService {
        OnboardingServiceImpl()
    }
    
    public var authenticationService: Domain.AuthenticationService {
        AuthenticationServiceImpl()
    }
    
    public init() {}
}
