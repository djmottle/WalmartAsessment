//
//  MockAPIClient.swift
//  WalmartAsessment
//
//  Created by David Mottle on 2/27/25.
//

import Foundation

//MARK: - MockAPIClient
class MockAPIClient: APIClientProtocol {
    static let shared = MockAPIClient()
    
    public init() {}

    func fetchData() async throws -> [Country] {
        guard let url = Bundle.main.url(forResource: "MockData", withExtension: "json") else {
            throw APIError.badURL
        }
        
        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode([Country].self, from: data)
        } catch {
            throw APIError.decoderError
        }
    }
}

