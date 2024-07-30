//
//  ComponentView.swift
//  Tendable
//
//  Created by Vijay Radake.
//

import SwiftUI

struct EmailTextField: View {
    @Binding var text: String
    
    var body: some View {
        TextField("Enter Email", text: $text)
            .textFieldStyle(.outlined)
            .autocorrectionDisabled()
            .textInputAutocapitalization(.never)
    }
}

struct PasswordTextField: View {
    @Binding var text: String
    
    var body: some View {
        SecureField("Enter Password", text: $text)
            .textFieldStyle(.outlined)
    }
}

#Preview {
    Group {
        EmailTextField(text: .constant(""))
        PasswordTextField(text: .constant(""))
    }
    .padding()
}
