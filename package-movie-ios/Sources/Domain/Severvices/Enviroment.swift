//
//  Environment.swift
//  
//
//  Created by Luu Phan on 03/03/2023.
//

import Foundation

import Foundation
import DependencyKit

public protocol Environment {
    var baseUrl: URL { get }
    var apiKey: String { get }
}

public protocol EnvironmentProvider {
    var env: Environment { get }
}

extension EnvironmentProvider {
    public var env: Environment {
        Container.configurationEnvironment()
    }
}

public enum EnvironmmentMode: String {
    case development = "Development"
    case staging     = "Staging"
    case production  = "Production"
}
