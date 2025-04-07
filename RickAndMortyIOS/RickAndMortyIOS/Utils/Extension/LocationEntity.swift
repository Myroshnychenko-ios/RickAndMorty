//
//  LocationEntity.swift
//  RickAndMortyIOS
//
//  Created by Максим Мирошниченко on 07.04.2025.
//

import Foundation

extension LocationEntity {

    func toObject() -> LocationObject {
        return LocationObject(name: self.name, url: self.url)
    }

}
