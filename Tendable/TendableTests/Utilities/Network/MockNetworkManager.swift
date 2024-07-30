//
//  MockNetworkManager.swift
//  TendableTests
//
//  Created by Vijay Radake.
//

import Foundation
@testable import Tendable

class MockNetworkManager: NetworkManagerProtocol, MockNetworkManagerProtocol {
    func performRequest<T>(service: APIService, resposeType: T.Type) async -> Result<T, Error> where T : Decodable {
        mockResponse(service, responseType: resposeType)
    }
}
