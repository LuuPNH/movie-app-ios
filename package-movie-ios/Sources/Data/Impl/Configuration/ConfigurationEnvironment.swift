//
//  ConfigurationEnvironment.swift
//  
//
//  Created by Luu Phan on 03/03/2023.
//

import Foundation
import Domain

public final class ConfigurationEnvironment {
    private let config: NSDictionary
    
    public init(config: NSDictionary) {
        self.config = config
    }
    
    public convenience init(mode: EnvironmmentMode) {
        let bundle = Bundle.module
        let configFile = bundle.path(forResource: "ConfigurationEnvironment", ofType: "plist") ?? .init()
        let config = NSDictionary(contentsOfFile: configFile)
        
        let dict = NSMutableDictionary()
        
        if let commonConfig = config?["Common"] as? [AnyHashable: String] {
            dict.addEntries(from: commonConfig)
        }
        
        if let environmentConfig = config?[mode.rawValue] as? [AnyHashable: Any] {
            dict.addEntries(from: environmentConfig)
        }
        
        self.init(config: dict)
    }
}

extension ConfigurationEnvironment: Environment {
    public var baseUrl: URL {
        
        let url = config.value(forKey: "baseUrl") as? String
        
        return URL(string: url ?? "")!
    }
    
    public var apiKey: String {
        let apiKey = config.value(forKey: "apiKey") as? String
        
        return apiKey ?? ""
        
    }
}
