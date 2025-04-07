//
//  CharactersRouter.swift
//  RickAndMortyIOS
//
//  Created by Максим Мирошниченко on 04.04.2025.
//

import Foundation
import UIKit

protocol CharactersRouterProtocol {

    func showDetails(with character: CharacterObject)

}

final class CharactersRouter: CharactersRouterProtocol {

    weak var viewController: UIViewController?

    func showDetails(with character: CharacterObject) {
        let detailsViewController = DetailsConfigurator.configure(with: character)
        self.viewController?.navigationController?.pushViewController(detailsViewController, animated: true)
    }

}
