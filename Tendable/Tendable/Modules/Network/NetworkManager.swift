//
//  NetworkManager.swift
//  Tendable
//
//  Created by Vijay Radake.
//

import Foundation

enum AppError: Error {
    case invalidResponse
    case invalidStatusCode(Int)
}

protocol NetworkManagerProtocol {
    func performRequest<T: Decodable>(service: APIService, resposeType: T.Type) async -> Result<T, Error>
}

class NetworkManager: NetworkManagerProtocol {
    
    func performRequest<T: Decodable>(service: APIService, resposeType: T.Type) async -> Result<T, Error> {
        do {
            let (data, response) = try await URLSession.shared.data(for: service.request)
            guard let httpResponse = response as? HTTPURLResponse else {
                throw AppError.invalidResponse
            }
            if !(200..<300).contains(httpResponse.statusCode) {
                throw AppError.invalidStatusCode(httpResponse.statusCode)
            }
            if data.isEmpty && httpResponse.statusCode == 200 {
                if let string = "{}".data(using: .utf8),
                   let emptyModel = try? JSONDecoder().decode(T.self, from: string) {
                    return .success(emptyModel)
                }
            }
            let decodedResponse = try JSONDecoder().decode(T.self, from: data)
            return .success(decodedResponse)
        } catch {
            return .failure(error)
        }
    }
}
