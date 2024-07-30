//
//  RegisterView.swift
//  Tendable
//
//  Created by Vijay Radake.
//

import SwiftUI

struct RegisterView: View {
    @StateObject var viewModel = RegisterViewModel()
    @State private var errorMessage: String?
    
    var completion: (() -> Void)?
    
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
        .onReceive(viewModel.$registrationResult) { result in
            switch result {
            case .none:
                break
            case .success:
                completion?()
            case .failed(let message):
                errorMessage = message
            }
        }
    }
    
    var loginViewContainer: some View {
        VStack(alignment: .leading, spacing: 20) {
            EmailTextField(text: $viewModel.email)
            PasswordTextField(text: $viewModel.password)
            Button(action: viewModel.register) {
                Text("Register")
                    .frame(maxWidth: .infinity)
            }
            .padding()
            .background(viewModel.isValidInput ? Color.blue : Color.gray)
            .foregroundStyle(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 6, style: .continuous))
            .disabled(!viewModel.isValidInput)
            
            if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundStyle(Color.red)
            }
        }
    }
}

#Preview {
    RegisterView()
}
