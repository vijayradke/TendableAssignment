//
//  APIService+Extension.swift
//  TendableTests
//
//  Created by Vijay Radake.
//

import Foundation
@testable import Tendable

protocol MockVisionServiceProtocol {
    var mockFilePath: String? { get }
}

extension InspectionService: MockVisionServiceProtocol {
    var mockFilePath: String? {
        switch self {
        case .startInspection:
            return "StartInspection"
        case .submitInspection:
            return "SubmitInspection"
        }
    }
}
