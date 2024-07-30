//
//  TextFieldStyle.swift
//  Tendable
//
//  Created by Vijay Radake.
//

import SwiftUI

struct OutlinedTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(12)
            .overlay {
                RoundedRectangle(cornerRadius: 6, style: .continuous)
                    .stroke(Color.gray, lineWidth: 1.0)
            }
    }
}

extension TextFieldStyle where Self == OutlinedTextFieldStyle {
    static var outlined: OutlinedTextFieldStyle {
        OutlinedTextFieldStyle()
    }
}
