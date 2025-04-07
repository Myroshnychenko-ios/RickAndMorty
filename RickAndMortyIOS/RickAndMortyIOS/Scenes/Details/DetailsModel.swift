//
//  DetailsModel.swift
//  RickAndMortyIOS
//
//  Created by Максим Мирошниченко on 07.04.2025.
//

import Foundation

enum DetailsModel {

    enum GetCharacter {

        struct Response: Decodable {
            let character: CharacterObject
        }

        struct ViewModel {
            let character: CharacterObject
        }

    }

    enum GetEpisodes {

        struct Request: HTTPRequest {

            typealias ResponseType = [EpisodeObject]

            let ids: [Int]
            var baseURL: String { Constants.RickAndMortyAPI.baseURL }
            var path: String {
                let idString = ids.map { String($0) }.joined(separator: ",")
                return "\(Constants.RickAndMortyAPI.episodePath)/\(idString)"
            }
            var method: HTTPMethod { .get }
            var queryItems: [URLQueryItem]? { nil }
            var headers: [String: String]? { nil }
            var body: Data? { nil }

            init(episodes: [String]?) {
                if let episodes = episodes {
                    let ids = episodes.compactMap { URL(string: $0)?.pathComponents.last }.compactMap { Int($0) }
                    self.ids = ids
                } else {
                    self.ids = []
                }
            }

        }

        struct Response: Decodable {
            let results: [EpisodeObject]
        }

        struct ViewModel {
            let episodes: [EpisodeObject]
        }

    }

}
