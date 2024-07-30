//
//  LoginViewModel.swift
//  Tendable
//
//  Created by Vijay Radake.
//

import Foundation

class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var errorMessage: String?
    @Published var isLoginSuccess: Bool = false
    @Published var isLoading: Bool = false
    
    var isValidInput: Bool {
        let trimmedEmail = email.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedPassword = password.trimmingCharacters(in: .whitespacesAndNewlines)
        return !trimmedEmail.isEmpty && !trimmedPassword.isEmpty
    }
    
    let networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func login() {
        isLoading = true
        let model = LoginRequestModel(email: email, password: password)
        let loginService = AuthService.login(requestModel: model)
        Task {
            let result = await networkManager.performRequest(service: loginService, resposeType: EmptyResponseModel.self)
            await MainActor.run {
                self.isLoading = false
                switch result {
                case .success(let model):
                    self.isLoginSuccess = true
                    Preference.userEmail = self.email
                case .failure(let error):
                    self.parseError(error)
                }
            }
        }
    }
    
    private func parseError(_ error: Error) {
        print("Failed with error: \(error)")
        switch error {
        case let appError as AppError:
            switch appError {
            case .invalidResponse:
                errorMessage = "Failed to login"
            case .invalidStatusCode(let statusCode):
                errorMessage = (statusCode == 401) ? "Invalid Credentials or User does not exist." : "Failed to login"
            }
        default:
            errorMessage = "Failed to login"
        }
    }
}
