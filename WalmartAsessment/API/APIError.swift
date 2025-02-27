//
//  APIError.swift
//  WalmartAsessment
//
//  Created by David Mottle on 2/26/25.
//

import Foundation

//MARK: - API Errors
enum APIError: Error, CustomStringConvertible {
    case badRequest
    case badResponse(statusCode: Int)
    case badURL
    case decoderError
}

extension APIError {
    var description: String {
        switch self {
        case .badRequest:
            return "Error: Bad request"
        case .badResponse(let statusCode):
            return "Error: Bad response. Status code: \(statusCode)"
        case .badURL:
            return "Error: Bad URL"
        case .decoderError:
            return "Decoder error"
        }
    }
}
