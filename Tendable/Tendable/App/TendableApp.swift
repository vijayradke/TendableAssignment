//
//  TendableApp.swift
//  Tendable
//
//  Created by Vijay Radake.
//

import SwiftUI

@main
struct TendableApp: App {
    @StateObject var authStateManager: AuthStateManager = AuthStateManager()

    var body: some Scene {
        WindowGroup {
            ApplicationSwitcher()
                .environmentObject(authStateManager)
        }
    }
}


struct ApplicationSwitcher: View {
    @EnvironmentObject var authStateManager: AuthStateManager
    
    var body: some View {
        switch authStateManager.userState {
        case .loggedIn:
            NavigationStack {
                HomeView()
            }
        case .loggedOut:
            AuthView()
        }
    }
}
