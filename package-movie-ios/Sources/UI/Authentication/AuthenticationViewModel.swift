//
//  File.swift
//  
//
//  Created by Luu Phan on 10/01/2023.
//

import Foundation
import Domain
import DependencyKit
import Combine

public class AuthenticationViewModel: ObservableObject {
    
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var authStatus: AuthStatus = AuthStatus.none
    @Published var isShowLoading = false
    @Published var errorLogin = ""
    @Published var isEnableBtnLogin = false
    var subcription = Set<AnyCancellable>()
    
    @Injected(Container.authenticationUseCase) var authenticationUseCase
    
    public init() {
        $username
            .combineLatest($password)
            .map {
                $0.count >= 5
                && $1.count >= 6
            }
            .sink { [weak self] in
                self?.isEnableBtnLogin = $0
            }
            .store(in: &subcription)
    }
    
    func login()  {
        Task{ @MainActor in
            do {
                isShowLoading = true
                let result = try await authenticationUseCase(.init(username: username, password: password))
                authStatus = result
                isShowLoading = false
            } catch {
                if let e = error as? AuthError
                {
                    authStatus = AuthStatus.loginFailed
                    errorLogin = e.rawValue
                }
                isShowLoading = false
            }
        }
    }
}
