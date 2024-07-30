//
//  RegisterViewModel.swift
//  Tendable
//
//  Created by Vijay Radake.
//

import Foundation

enum RegistrationResult {
    case none
    case success
    case failed(message: String)
}

class RegisterViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var presentError: Bool = false
    @Published var registrationResult: RegistrationResult = .none
    @Published var isLoading: Bool = false
    
    var isValidInput: Bool {
        let trimmedEmail = email.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedPassword = password.trimmingCharacters(in: .whitespacesAndNewlines)
        return !trimmedEmail.isEmpty && !trimmedPassword.isEmpty
    }
    
    let networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManager = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func register() {
        isLoading = true
        let model = LoginRequestModel(email: email, password: password)
        let service = AuthService.register(requestModel: model)
        Task {
            let result = await networkManager.performRequest(service: service, resposeType: EmptyResponseModel.self)
            await MainActor.run {
                self.isLoading = false
                switch result {
                case .success:
                    self.registrationResult = .success
                case .failure(let error):
                    self.parseError(error)
                }
            }
        }
    }
    
    private func parseError(_ error: Error) {
        print("Failed with error: \(error)")
        let generalFailure: RegistrationResult = .failed(message: "Failed to register, Please try again.")
        switch error {
        case let appError as AppError:
            switch appError {
            case .invalidResponse:
                registrationResult = generalFailure
            case .invalidStatusCode(let statusCode):
                registrationResult = (statusCode == 401) ? .failed(message: "User already registered, Please login.") : generalFailure
            }
        default:
            registrationResult = generalFailure
        }
    }
}
