//
//  InspectionService.swift
//  Tendable
//
//  Created by Vijay Radake.
//

import Foundation

enum InspectionService: APIService {
    case startInspection
    case submitInspection(requestModel: SubmitInspectionRequestModel)
    
    var method: HTTPMethod {
        switch self {
        case .startInspection:
            return .get
        case .submitInspection:
            return .post
        }
    }
    
    var path: String {
        switch self {
        case .startInspection:
            return "inspections/start"
        case .submitInspection:
            return "inspections/submit"
        }
    }
    
    var requestModel: Codable? {
        switch self {
        case .startInspection:
            return nil
        case .submitInspection(let requestModel):
            return requestModel
        }
    }
}
