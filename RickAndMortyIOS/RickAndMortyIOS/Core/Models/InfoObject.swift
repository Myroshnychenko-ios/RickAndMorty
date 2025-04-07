//
//  InfoObject.swift
//  RickAndMortyIOS
//
//  Created by Максим Мирошниченко on 07.04.2025.
//

import Foundation

struct InfoObject: Decodable {
    let count: Int?
    let pages: Int?
    let next: String?
    let prev: String?
}
