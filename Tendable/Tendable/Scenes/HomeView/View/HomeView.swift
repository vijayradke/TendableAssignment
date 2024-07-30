//
//  HomeView.swift
//  Tendable
//
//  Created by Vijay Radake.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var authStateManager: AuthStateManager
    @StateObject var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 50) {
                VStack(alignment: .leading, spacing: 20) {
                    HStack {
                        Text("Hello")
                        Text(viewModel.displayName)
                        Spacer()
                    }
                }
                VStack(spacing: 40) {
                    NavigationLink(destination: ShowcaseInpectionView()) {
                        actionView(text: "Start New Inspection")
                    }
                    NavigationLink(destination: StoredInspectionListView()) {
                        actionView(text: "Show Stored Inspection")
                    }
                }
                Spacer()
            }
            .padding(20)
            .navigationTitle("Tendable")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    logoutButton
                }
            }
        }
    }
    
    var logoutButton: some View {
        Button {
            authStateManager.logout()
        } label: {
            Text("Logout")
        }
    }
    
    func actionView(text: String) -> some View {
        Text(text)
            .padding()
            .background(.blue)
            .foregroundStyle(Color.white)
            .cornerRadius(6)
    }
}

#Preview {
    HomeView()
}
