//
//  CharacterObject.swift
//  RickAndMortyIOS
//
//  Created by Максим Мирошниченко on 07.04.2025.
//

import Foundation

struct CharacterObject: Decodable {
    let id: Int
    let name: String?
    let status: String?
    let species: String?
    let type: String?
    let gender: String?
    let origin: OriginObject?
    let location: LocationObject?
    let image: String?
    let episode: [String]?
    let url: String?
    let created: String?
}
