//
//  File.swift
//  
//
//  Created by Luu Phan on 10/01/2023.
//

import Foundation
import Domain

public class AuthenticationServiceImpl: AuthenticationService {
    public func signOut() async throws -> Domain.AuthStatus {
        return AuthStatus.none
    }
    
    public func signIn(params: Domain.AuthenParams) async throws -> Domain.AuthStatus {
        
        let matchUsername = "admin"
        let matchPassword = "123123"
        try await Task.sleep(nanoseconds: 2_000_000_000)//2s
        
        if params.username == matchUsername, params.password == matchPassword {
            return AuthStatus.loginSuccess
        }
        
        throw AuthError.incorrectEmailPassword;
    }
    
    
}
