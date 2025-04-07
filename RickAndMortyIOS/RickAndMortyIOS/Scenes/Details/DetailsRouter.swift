//
//  DetailsRouter.swift
//  RickAndMortyIOS
//
//  Created by Максим Мирошниченко on 06.04.2025.
//

import Foundation
import UIKit

protocol DetailsRouterProtocol {

    func popViewController()

}

final class DetailsRouter: DetailsRouterProtocol {

    weak var viewController: UIViewController?

    func popViewController() {
        self.viewController?.navigationController?.popViewController(animated: true)
    }

}
