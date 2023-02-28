//
//  File.swift
//  
//
//  Created by Luu Phan on 10/01/2023.
//

import Foundation
import Domain

public class DataFactory: DataProvider {
    
    public init() {}
    
    public var userDefaultsService: Domain.KeyValue {
        KeyValueStore.shared
    }
    
    public var onboardingService: Domain.OnboardingService {
        OnboardingServiceImpl()
    }
    
    public var authenticationService: Domain.AuthenticationService {
        AuthenticationServiceImpl()
    }
}
