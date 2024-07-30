//
//  Bundle+Extension.swift
//  TendableTests
//
//  Created by Vijay Radake.
//

import Foundation

extension Bundle {
    static func contentsOfFile<T: Decodable>(_ fileName: String, extension ext: String? = nil, fromBundleWithClass aClass: AnyClass, of type: T.Type) -> T? {
        let bundle = Bundle(for: aClass)
        do {
            if let url = bundle.url(forResource: fileName, withExtension: ext) ?? bundle.url(forResource: fileName, withExtension: nil) {
                let data = try Data(contentsOf: url)
                let model = try JSONDecoder().decode(type, from: data)
                return model
            }
        } catch {
            print("Error loading resource \(fileName) from Bundle ", error)
        }
        return nil
    }
}
