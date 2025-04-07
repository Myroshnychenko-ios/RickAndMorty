//
//  CharactersInteractor.swift
//  RickAndMortyIOS
//
//  Created by Максим Мирошниченко on 04.04.2025.
//

import Foundation

protocol CharactersInteractorProtocol {

    func getCharacters(with request: CharactersModel.GetCharacters.Request)

}

class CharactersInteractor: CharactersInteractorProtocol {

    // MARK: - VIP Properties

    var presenter: CharactersPresenterProtocol?

    // MARK: - Private Properties

    private let httpService = HTTPService()

    private var page = 1
    private var isLast = false

    // MARK: - CharactersInteractorProtocol

    func getCharacters(with request: CharactersModel.GetCharacters.Request) {
        guard !self.isLast else { return }
        var getCharactersRequest = request
        if let page = getCharactersRequest.page {
            self.page = page
        } else {
            getCharactersRequest.page = self.page
        }
        self.httpService.request(getCharactersRequest) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self.page += 1
                    self.isLast = response.info.next == nil
                    self.presenter?.presentCharacters(with: response, isLast: self.isLast)
                case .failure(let error):
                    print(error.description)
                }
            }
        }
    }

}
