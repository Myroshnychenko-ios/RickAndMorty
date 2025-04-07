//
//  HTTPError.swift
//  RickAndMortyIOS
//
//  Created by Максим Мирошниченко on 04.04.2025.
//

import Foundation

enum HTTPError: Error, CustomStringConvertible {

    case invalidURL
    case requestFailed(Int)
    case decodingFailed(Error)
    case noData
    case unknown(Error)

    var description: String {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .requestFailed(let statusCode):
            return "Request failed with status code: \(statusCode)"
        case .decodingFailed(let error):
            return "Failed to decode: \(error.localizedDescription)"
        case .noData:
            return "No data received"
        case .unknown(let error):
            return "Unknown error: \(error.localizedDescription)"
        }
    }

}
