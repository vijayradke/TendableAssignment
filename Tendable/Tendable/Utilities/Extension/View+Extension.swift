//
//  View+Extension.swift
//  Tendable
//
//  Created by Vijay Radake.
//

import Foundation
import SwiftUI

extension View {
    func adaptivePadding() -> some View {
        let factor = UIDevice.isIPad ? 0.2 : 0.02
        return self.padding(.horizontal, UIScreen.screenWidth * factor)
    }
}
