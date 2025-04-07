//
//  OriginEntity.swift
//  RickAndMortyIOS
//
//  Created by Максим Мирошниченко on 07.04.2025.
//

import Foundation

extension OriginEntity {

    func toObject() -> OriginObject {
        return OriginObject(name: self.name, url: self.url)
    }

}
