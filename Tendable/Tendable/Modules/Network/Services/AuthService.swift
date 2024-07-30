//
//  AuthService.swift
//  Tendable
//
//  Created by Vijay Radake.
//

import Foundation

enum AuthService: APIService {
    case login(requestModel: LoginRequestModel)
    case register(requestModel: LoginRequestModel)
    
    var method: HTTPMethod {
        switch self {
        case .login, .register:
            return .post
        }
    }
    
    var path: String {
        switch self {
        case .login:
            return "login"
        case .register:
            return "register"
        }
    }
        
    var requestModel: Codable? {
        switch self {
        case .login(let requestModel):
            return requestModel
        case .register(let requestModel):
            return requestModel
        }
    }
    
}
