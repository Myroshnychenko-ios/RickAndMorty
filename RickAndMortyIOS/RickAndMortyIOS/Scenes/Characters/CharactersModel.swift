//
//  CharactersModel.swift
//  RickAndMortyIOS
//
//  Created by Максим Мирошниченко on 04.04.2025.
//

import Foundation

enum CharactersModel {

    enum GetCharacters {

        struct Request: HTTPRequest {

            typealias ResponseType = Response

            var page: Int?
            var baseURL: String { Constants.RickAndMortyAPI.baseURL }
            var path: String { Constants.RickAndMortyAPI.characterPath }
            var method: HTTPMethod { .get }
            var queryItems: [URLQueryItem]? { [URLQueryItem(name: "page", value: "\(self.page ?? 0)")] }
            var headers: [String : String]? { nil }
            var body: Data? { nil }

            init(page: Int? = nil) {
                self.page = page
            }

        }

        struct Response: Decodable {
            let info: InfoObject
            let results: [CharacterObject]
        }

        struct ViewModel {
            let characters: [CharacterObject]
            let isLast: Bool
        }

    }

}
