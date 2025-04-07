//
//  DetailsPresenter.swift
//  RickAndMortyIOS
//
//  Created by Максим Мирошниченко on 06.04.2025.
//

import Foundation

protocol DetailsPresenterProtocol {

    func presentCharacters(with response: DetailsModel.GetCharacter.Response)
    func presentEpisodes(with response: DetailsModel.GetEpisodes.Response)

}

class DetailsPresenter: DetailsPresenterProtocol {

    // MARK: - VIP Properties

    weak var viewController: DetailsViewControllerProtocol?

    // MARK: - DetailsPresenterProtocol

    func presentCharacters(with response: DetailsModel.GetCharacter.Response) {
        let viewModel = DetailsModel.GetCharacter.ViewModel(character: response.character)
        self.viewController?.displayCharacter(viewModel)
    }

    func presentEpisodes(with response: DetailsModel.GetEpisodes.Response) {
        let viewModel = DetailsModel.GetEpisodes.ViewModel(episodes: response.results)
        self.viewController?.displayEpisodes(viewModel)
    }

}
