//
//  CharactersInteractor.swift
//  RickAndMortyIOS
//
//  Created by Максим Мирошниченко on 04.04.2025.
//

import Foundation

protocol CharactersInteractorProtocol {

    func getCharacters(with request: CharactersModel.GetCharacters.Request)
    func save(_ characters: [CharacterObject])

}

class CharactersInteractor: CharactersInteractorProtocol {

    // MARK: - VIP Properties

    var presenter: CharactersPresenterProtocol?

    // MARK: - Private Properties

    private let monitor = NWMonitor()
    private let httpService = HTTPService()
    private let storageService = StorageService()

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
                    self.isLast = response.info?.next == nil
                    self.presenter?.presentCharacters(with: response, isLast: self.isLast)
                case .failure(let error):
                    if !self.monitor.isConnected {
                        let characters = self.storageService.fetch()
                        self.presenter?.presentCharacters(with: CharactersModel.GetCharacters.Response(info: nil, results: characters), isLast: true)
                    }
                }
            }
        }
    }

    func save(_ characters: [CharacterObject]) {
        self.storageService.save(characters)
    }

}
