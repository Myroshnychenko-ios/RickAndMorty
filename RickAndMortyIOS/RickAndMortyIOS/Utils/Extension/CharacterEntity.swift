//
//  CharacterEntity.swift
//  RickAndMortyIOS
//
//  Created by Максим Мирошниченко on 07.04.2025.
//

import Foundation
import CoreData

extension CharacterEntity {

    func configure(with object: CharacterObject, context: NSManagedObjectContext) {
        self.id = Int64(object.id)
        self.name = object.name
        self.status = object.status
        self.species = object.species
        self.type = object.type
        self.gender = object.gender
        self.image = object.image
        if let originObject = object.origin {
            let originEntity = OriginEntity(context: context)
            originEntity.name = originObject.name
            originEntity.url = originObject.url
            self.origin = originEntity
        }
        if let locationObject = object.location {
            let locationEntity = LocationEntity(context: context)
            locationEntity.name = locationObject.name
            locationEntity.url = locationObject.url
            self.location = locationEntity
        }
    }

    func toObject() -> CharacterObject {
        return CharacterObject(id: Int(self.id), name: self.name, status: self.status, species: self.species, type: self.type, gender: self.gender, origin: self.origin?.toObject(), location: self.location?.toObject(), image: self.image, episode: nil, url: nil, created: nil)
    }

}
