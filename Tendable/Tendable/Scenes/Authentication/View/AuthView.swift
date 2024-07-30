//
//  AuthView.swift
//  Tendable
//
//  Created by Vijay Radake.
//

import SwiftUI

enum ViewState {
    case login
    case register
}

struct AuthView: View {
    @State var viewState: ViewState = .login
    
    var body: some View {
        VStack {
            headerView
            Spacer()
            switch viewState {
            case .login:
                LoginView()
                loginViewFooter
                    .padding(.top, 20)
            case .register:
                RegisterView {
                    viewState = .login
                }
                registerViewFooter
                    .padding(.top, 20)
            }
            Spacer()
            Spacer()
            Spacer()
        }
        .adaptivePadding()
    }
    
    var headerView: some View {
        Text(viewState == .login ? "Login" : "Register")
            .font(.title)
    }
    
    var loginViewFooter: some View {
        HStack {
            Text("New User?")
            Button {
                viewState = .register
            } label: {
                Text("Register")
            }
        }
    }
    
    var registerViewFooter: some View {
        HStack {
            Text("Back to")
            Button {
                viewState = .login
            } label: {
                Text("Login")
            }
        }
    }
}

#Preview {
    AuthView()
}
