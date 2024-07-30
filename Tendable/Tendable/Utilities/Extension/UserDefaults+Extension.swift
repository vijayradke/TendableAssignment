//
//  UserDefaults+Extension.swift
//  Tendable
//
//  Created by Vijay Radake.
//

import Foundation

extension UserDefaults {
    subscript<T>(key: String) -> T? {
        get {
            value(forKey: key) as? T
        }
        set {
            set(newValue, forKey: key)
        }
    }

    subscript<T: RawRepresentable>(key: String) -> T? {
        get {
            if let rawValue = value(forKey: key) as? T.RawValue {
                return T(rawValue: rawValue)
            }
            return nil
        }
        set {
            set(newValue?.rawValue, forKey: key)
        }
    }
}
