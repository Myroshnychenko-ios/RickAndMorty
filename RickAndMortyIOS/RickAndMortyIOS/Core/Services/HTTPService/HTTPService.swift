//
//  HTTPService.swift
//  RickAndMortyIOS
//
//  Created by Максим Мирошниченко on 04.04.2025.
//

import Foundation

class HTTPService {

    // MARK: - Lifecycle

    init() {

    }

    // MARK: - Public Methods

    func request<T: HTTPRequest>(_ request: T, completion: @escaping (Result<T.ResponseType, HTTPError>) -> Void) {
        var components = URLComponents(string: request.baseURL)
        components?.path = request.path
        components?.queryItems = request.queryItems
        guard let url = components?.url else {
            completion(.failure(.invalidURL))
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.httpBody = request.body
        urlRequest.cachePolicy = .reloadIgnoringLocalCacheData
        print(urlRequest)
        request.headers?.forEach { urlRequest.setValue($1, forHTTPHeaderField: $0) }
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                completion(.failure(.unknown(error)))
                return
            }
            if let response = response as? HTTPURLResponse,
               !(200..<300).contains(response.statusCode) {
                completion(.failure(.requestFailed(response.statusCode)))
                return
            }
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            do {
                let decoded = try JSONDecoder().decode(T.ResponseType.self, from: data)
                completion(.success(decoded))
            } catch {
                completion(.failure(.decodingFailed(error)))
            }
        }
        task.resume()
    }

}
