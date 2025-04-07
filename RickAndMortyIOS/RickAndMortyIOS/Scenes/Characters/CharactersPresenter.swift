//
//  CharactersPresenter.swift
//  RickAndMortyIOS
//
//  Created by Максим Мирошниченко on 04.04.2025.
//

import Foundation

protocol CharactersPresenterProtocol {

    func presentCharacters(with response: CharactersModel.GetCharacters.Response, isLast: Bool)

}

class CharactersPresenter: CharactersPresenterProtocol {

    // MARK: - VIP Properties

    weak var viewController: CharactersViewControllerProtocol?

    // MARK: - CharactersPresenterProtocol

    func presentCharacters(with response: CharactersModel.GetCharacters.Response, isLast: Bool) {
        let viewModel = CharactersModel.GetCharacters.ViewModel(characters: response.results, isLast: isLast)
        self.viewController?.displayCharacters(viewModel)
    }
    
}
