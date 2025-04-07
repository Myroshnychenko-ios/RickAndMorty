//
//  EpisodeObject.swift
//  RickAndMortyIOS
//
//  Created by Максим Мирошниченко on 07.04.2025.
//

import Foundation

struct EpisodeObject: Decodable {
    let id: Int
    let name: String?
    let air_date: String?
    let episode: String?
    let characters: [String]?
    let url: String?
    let created: String?
}
