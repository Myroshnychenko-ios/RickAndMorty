//
//  DetailsConfigurator.swift
//  RickAndMortyIOS
//
//  Created by Максим Мирошниченко on 06.04.2025.
//

import Foundation
import UIKit

enum DetailsConfigurator {

    static func configure(with character: CharacterObject) -> UIViewController {
        let viewController = DetailsViewController()
        let interactor = DetailsInteractor(character: character)
        let presenter = DetailsPresenter()
        let router = DetailsRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        return viewController
    }

}
