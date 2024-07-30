//
//  AppPrimaryButton.swift
//  Tendable
//
//  Created by Vijay Radake.
//

import SwiftUI

struct AppPrimaryButton: View {
    let title: String
    let action: () -> Void
    let backgroundColor: Color
    var textColor: Color
    
    init(title: String, action: @escaping () -> Void, backgroundColor: Color = .blue, textColor: Color = .white) {
        self.title = title
        self.action = action
        self.backgroundColor = backgroundColor
        self.textColor = textColor
    }

    var body: some View {
        Button(action: action) {
            Text(title)
                .padding()
                .padding(.horizontal)
                .background(backgroundColor)
                .foregroundStyle(textColor)
                .cornerRadius(6.0)

        }
    }
}

#Preview {
    AppPrimaryButton(title: "Button", action: {})
}
