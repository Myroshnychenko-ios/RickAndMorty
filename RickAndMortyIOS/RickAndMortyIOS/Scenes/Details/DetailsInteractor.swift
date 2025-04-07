//
//  DetailsInteractor.swift
//  RickAndMortyIOS
//
//  Created by Максим Мирошниченко on 06.04.2025.
//

import Foundation

protocol DetailsInteractorProtocol {

    func getCharacter()
    func getEpisodes(with request: DetailsModel.GetEpisodes.Request)

}

class DetailsInteractor: DetailsInteractorProtocol {

    // MARK: - VIP Properties

    var presenter: DetailsPresenterProtocol?

    // MARK: - Private Properties

    private let httpService = HTTPService()

    private let character: CharacterObject

    // MARK: - Lifecycle

    init(character: CharacterObject) {
        self.character = character
    }

    // MARK: - DetailsInteractorProtocol

    func getCharacter() {
        self.presenter?.presentCharacters(with: DetailsModel.GetCharacter.Response(character: self.character))
    }

    func getEpisodes(with request: DetailsModel.GetEpisodes.Request) {
        guard request.ids.count > 0 else { return }
        self.httpService.request(request) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self.presenter?.presentEpisodes(with: DetailsModel.GetEpisodes.Response(results: response))
                case .failure(let error):
                    print(error.description)
                }
            }
        }
    }

}
