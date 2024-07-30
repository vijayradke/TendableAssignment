//
//  AuthStateManager.swift
//  Tendable
//
//  Created by Vijay Radake.
//

import Foundation

enum AuthState {
    case loggedIn
    case loggedOut
}

@MainActor
class AuthStateManager: ObservableObject {
    @Published private(set) var userState: AuthState = .loggedOut
    
    init() {
        checkForLogin()
    }
    
    func checkForLogin() {
        userState = Preference.userEmail.isEmpty ? .loggedOut : .loggedIn
    }
    
    func loginSuccess() {
        userState = .loggedIn
    }
    
    func logout() {
        Preference.userEmail = ""
        userState = .loggedOut
    }
}
