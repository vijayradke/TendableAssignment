//
//  LoginView.swift
//  Tendable
//
//  Created by Vijay Radake.
//

import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject var authStateManager: AuthStateManager
    @StateObject var viewModel = LoginViewModel()
    
    var body: some View {
        ZStack {
            VStack {
                loginViewContainer
            }
            if viewModel.isLoading {
                ProgressView()
                    .scaleEffect(2)
            }
        }
        .padding()
        .disabled(viewModel.isLoading)
        .onReceive(viewModel.$isLoginSuccess) { loginSuccess in
            if loginSuccess {
                authStateManager.loginSuccess()
            }
        }
    }
        
    var loginViewContainer: some View {
        VStack(alignment: .leading, spacing: 20) {
            EmailTextField(text: $viewModel.email)
            PasswordTextField(text: $viewModel.password)
            Button(action: viewModel.login) {
                Text("Login")
                    .frame(maxWidth: .infinity)
            }
            .padding()
            .background(viewModel.isValidInput ? Color.blue : Color.gray)
            .foregroundStyle(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 6, style: .continuous))
            .disabled(!viewModel.isValidInput)
            
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundStyle(Color.red)
            }
        }
    }
}

#Preview {
    LoginView()
}
