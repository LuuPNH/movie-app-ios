//
//  SwiftUIView.swift
//  
//
//  Created by Luu Phan on 10/01/2023.
//

import SwiftUI
import Domain

public struct AuthentiCationView: View {
    
    @ObservedObject var viewModel: AuthenticationViewModel
    
    public init(viewModel: AuthenticationViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        ZStack {
            VStack(spacing: 20) {
                Spacer()
                HStack {
                    Text("User name: ")
                        .font(.headline)
                    
                    TextField(
                        "admin",
                        text: $viewModel.username
                    )
                    .foregroundColor(.black)
                }
                .padding(.horizontal, 20)
                HStack {
                    Text("Password: ")
                        .font(.headline)
                    
                    SecureField(
                        "123123",
                        text: $viewModel.password
                    )
                    .keyboardType(.numberPad)
                    .foregroundColor(.black)
                    
                }
                .padding(.horizontal, 20)
                
                Button(action: viewModel.login) {
                    Text("Sign In")
                        .foregroundColor(.black)
                }
                .disabled(!viewModel.isEnableBtnLogin)
                .buttonStyle(.bordered)
                .background(viewModel.isEnableBtnLogin ? .blue : .gray)
                .cornerRadius(5)
                
                let checkLogin = viewModel.authStatus == AuthStatus.loginFailed
                
                Text( checkLogin ? viewModel.errorLogin : "Input infomation to use application")
                    .foregroundColor( checkLogin ? .red : .white)
                    .fontWeight(.bold)
                
                
                
                
                Spacer()
            }
            .background(.linearGradient(Gradient(colors: [.pink, .blue]), startPoint: .top, endPoint: .bottom))
            
            if viewModel.isShowLoading {
                Color.black.opacity(0.5).ignoresSafeArea()
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
            }
            if viewModel.authStatus == AuthStatus.loginFailed {
                
            }
        }
    }
}
