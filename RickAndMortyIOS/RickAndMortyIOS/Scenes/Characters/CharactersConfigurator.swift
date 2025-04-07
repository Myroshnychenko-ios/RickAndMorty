//
//  CharactersConfigurator.swift
//  RickAndMortyIOS
//
//  Created by Максим Мирошниченко on 04.04.2025.
//

import Foundation
import UIKit

enum CharactersConfigurator {

    static func configure() -> UIViewController {
        let viewController = CharactersViewController()
        let interactor = CharactersInteractor()
        let presenter = CharactersPresenter()
        let router = CharactersRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        return viewController
    }

}
