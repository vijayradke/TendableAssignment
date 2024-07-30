//
//  DataStore.swift
//  TendableTests
//
//  Created by Vijay Radake.
//

import Foundation

@testable import Tendable

class DataStore {
    static func inspectionResponseModel() -> InspectionResponseModel? {
        let responseModel = Bundle.contentsOfFile("StartInspection", extension: "json", fromBundleWithClass: Self.self, of: InspectionResponseModel.self)
        return responseModel
    }
}
