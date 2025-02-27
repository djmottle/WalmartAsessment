//
//  APIClient.swift
//  WalmartAsessment
//
//  Created by David Mottle on 2/26/25.
//

import Foundation

//MARK: - APIClientProtocol
protocol APIClientProtocol {
    func fetchData() async throws -> [Country]
}

//MARK: - APIClient
class APIClient: APIClientProtocol {
    static let shared = APIClient()
    
    public init() {}

    func fetchData() async throws -> [Country] {
        guard let url = URL(string: Constants.URL.url) else {
            throw APIError.badURL
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw APIError.badRequest
            }
            
            do {
                return try JSONDecoder().decode([Country].self, from: data)
            } catch {
                throw APIError.decoderError
            }
        } catch {
            throw error
        }
    }
}
