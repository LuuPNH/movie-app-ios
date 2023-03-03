//
//  AuthenticationPluggin.swift
//  data
//
//  Created by Phat Le on 01/09/2021.
//

import Foundation
import Moya
import DependencyKit

class AuthenticationPlugin: PluginType {
    @Injected(Container.userDefaults) var userDefaults

    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        
//        request.headers.add(.authorization(bearerToken: token))

        return request
    }
}
