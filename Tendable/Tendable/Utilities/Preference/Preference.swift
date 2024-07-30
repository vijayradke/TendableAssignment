//
//  Preference.swift
//  Tendable
//
//  Created by Vijay Radake.
//

import Foundation

struct Preference {
    static var userEmail: String {
        get { UserDefaults.standard[#function] ?? "" }
        set { UserDefaults.standard[#function] = newValue }
    }
}
