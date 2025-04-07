//
//  HTTPRequest.swift
//  RickAndMortyIOS
//
//  Created by Максим Мирошниченко on 04.04.2025.
//

import Foundation

protocol HTTPRequest {

    associatedtype ResponseType: Decodable

    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var queryItems: [URLQueryItem]? { get }
    var headers: [String: String]? { get }
    var body: Data? { get }

}
