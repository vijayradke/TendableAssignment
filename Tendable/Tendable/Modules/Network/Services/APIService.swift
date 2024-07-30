//
//  APIService.swift
//  Tendable
//
//  Created by Vijay Radake.
//

import Foundation

protocol APIService {
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: [String: Any]? { get }
    var requestModel: Codable? { get }
    var request: URLRequest { get }
}

extension APIService {
    var url: URL {
        let urlString = APIConstant.baseUrl + path
        let stringWithEncoding = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        return URL(string: stringWithEncoding)!
    }
    
    var request: URLRequest {
        var aRequest = URLRequest(url: url)
        aRequest.timeoutInterval = 30
        aRequest.httpMethod = method.rawValue
        for (key, value) in commonHeaders {
            aRequest.setValue(value, forHTTPHeaderField: key)
        }
        if let parameters {
            aRequest.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])
        }
        if let requestModel {
            aRequest.httpBody = try? JSONEncoder().encode(requestModel)
        }
        return aRequest
    }
    
    var parameters: [String : Any]? {
        return nil
    }
    
    var commonHeaders: [String: String] {
        return ["Content-Type": "application/json"]
    }
}
