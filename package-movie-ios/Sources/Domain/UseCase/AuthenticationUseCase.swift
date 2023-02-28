//
//  File.swift
//  
//
//  Created by Luu Phan on 10/01/2023.
//

import Foundation
import DependencyKit

public class AuthenticateUseCase: AsyncUseCase {
    
    @Injected(Container.authenticationService) var authenticationService
    
    public func callAsFunction(_ input: AuthenParams) async throws -> AuthStatus {
        let login = try await authenticationService.signIn(params: input)
        
        return login
    }
    
    public typealias Input = AuthenParams
    
    public typealias Output = AuthStatus
    
}
