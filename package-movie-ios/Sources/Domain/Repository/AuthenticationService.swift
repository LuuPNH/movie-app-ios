//
//  File.swift
//  
//
//  Created by Luu Phan on 10/01/2023.
//

import Foundation

public protocol AuthenticationService {
    
    func signIn(params: AuthenParams) async throws -> AuthStatus
    func signOut() async throws -> AuthStatus
}

public enum AuthStatus {
    case loginSuccess
    case none
    case loginFailed
}

public enum AuthError: String, Error {
    case incorrectEmailPassword = "Login Failed"
}

public struct AuthenParams: Equatable {
    public let username: String
    public let password: String
    
    public init(username: String, password: String) {
        self.username = username
        self.password = password
    }
}


