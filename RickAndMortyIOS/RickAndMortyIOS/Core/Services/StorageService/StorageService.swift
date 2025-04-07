//
//  StorageService.swift
//  RickAndMortyIOS
//
//  Created by Максим Мирошниченко on 07.04.2025.
//

import Foundation
import UIKit
import CoreData

class StorageService {

    // MARK: - Private Properties

    private var context: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }

    // MARK: - Lifecycle

    init() {

    }

    // MARK: - Public Methods

    func removeAll() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "CharacterEntity")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
        do {
            try self.context.execute(deleteRequest)
        } catch {
            print("Failed to delete characters: \(error.localizedDescription)")
        }
    }

    func save(_ characters: [CharacterObject]) {
        self.removeAll()
        characters.forEach { character in
            let entity = CharacterEntity(context: self.context)
            entity.configure(with: character, context: self.context)
        }
        do {
            try self.context.save()
        } catch {
            print("❌ Failed to save characters: \(error.localizedDescription)")
        }
    }

    func fetch() -> [CharacterObject] {
        let request: NSFetchRequest<CharacterEntity> = CharacterEntity.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "id", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        do {
            let entities = try context.fetch(request)
            return entities.map { $0.toObject() }
        } catch {
            print("Failed to load characters: \(error.localizedDescription)")
            return []
        }
    }

}
