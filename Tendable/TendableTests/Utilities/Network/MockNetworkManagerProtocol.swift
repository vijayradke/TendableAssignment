//
//  MockNetworkManagerProtocol.swift
//  TendableTests
//
//  Created by Vijay Radake.
//

import Foundation
@testable import Tendable

protocol MockNetworkManagerProtocol {
    var bundle: Bundle { get }
    func mockResponse<T: Decodable>(_ apiService: APIService, responseType: T.Type) -> Result<T, Error>
}

extension MockNetworkManagerProtocol {
    var bundle: Bundle {
        Bundle(for: type(of: self) as! AnyClass)
    }
    
    func mockResponse<T: Decodable>(_ apiService: APIService, responseType: T.Type) -> Result<T, Error> {
        guard let service = apiService as? MockVisionServiceProtocol,
              let path = bundle.url(forResource: service.mockFilePath, withExtension: "json"),
              let data = try? Data(contentsOf: path),
              let responseModel = try? JSONDecoder().decode(responseType, from: data) else {
            return Result.failure(AppError.invalidResponse)
        }
        return Result.success(responseModel)
    }
}
