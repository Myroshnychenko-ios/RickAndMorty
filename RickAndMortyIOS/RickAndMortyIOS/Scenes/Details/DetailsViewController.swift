//
//  DetailsViewController.swift
//  RickAndMortyIOS
//
//  Created by Максим Мирошниченко on 06.04.2025.
//

import UIKit

protocol DetailsViewControllerProtocol: AnyObject {

    func displayCharacter(_ viewModel: DetailsModel.GetCharacter.ViewModel)
    func displayEpisodes(_ viewModel: DetailsModel.GetEpisodes.ViewModel)

}

class DetailsViewController: UIViewController {

    // MARK: - VIP Properties

    var interactor: DetailsInteractorProtocol?
    var router: DetailsRouterProtocol?

    // MARK: - Private Methods

    private lazy var tableView: UITableView = UITableView()

    private enum CharacterDetail: CaseIterable {

        case gender
        case status
        case species
        case origin
        case type
        case location

        var title: String {
            switch self {
            case .gender: return "Gender"
            case .status: return "Status"
            case .species: return "Specie"
            case .origin: return "Origin"
            case .type: return "Type"
            case .location: return "Location"
            }
        }

        func value(from character: CharacterObject?) -> String {
            switch self {
            case .gender:
                return character?.gender ?? "N/A"
            case .status:
                return character?.status ?? "N/A"
            case .species:
                return character?.species ?? "N/A"
            case .origin:
                return character?.origin?.name ?? "N/A"
            case .type: 
                return character?.type ?? "N/A"
            case .location: 
                return character?.location?.name ?? "N/A"
            }
        }
    }

    private var episodes: [EpisodeObject] = []
    private var character: CharacterObject?

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupLayouts()
        self.interactor?.getCharacter()
    }

    // MARK: - Private Methods

    @objc private func backButtonTapped() {
        self.router?.popViewController()
    }

}

extension DetailsViewController: DetailsViewControllerProtocol {

    // MARK: - DetailsViewControllerProtocol

    func displayCharacter(_ viewModel: DetailsModel.GetCharacter.ViewModel) {
        self.character = viewModel.character
        self.tableView.reloadData()
        guard let episodes = self.character?.episode else { return }
        self.interactor?.getEpisodes(with: DetailsModel.GetEpisodes.Request(episodes: episodes))
    }

    func displayEpisodes(_ viewModel: DetailsModel.GetEpisodes.ViewModel) {
        self.episodes = viewModel.episodes
        self.tableView.reloadData()
    }

}

extension DetailsViewController: UITableViewDataSource, UITableViewDelegate {

    // MARK: - UITableViewDataSource / UITableViewDelegate

    func numberOfSections(in tableView: UITableView) -> Int {
        return self.character == nil ? 0 : (2 + (self.episodes.count > 0 ? 1 : 0))
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 0
        case 1: return Self.CharacterDetail.allCases.count
        case 2: return self.episodes.count
        default: return 0
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            return ImageHeaderView(imageUrl: self.character?.image, title: self.character?.name)
        case 1:
            return HeaderView(title: "Informations")
        case 2:
            return HeaderView(title: "Episodes")
        default:
            return nil
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0: return 262.0
        case 1: return 72.0
        case 2: return 72.0
        default: return 0.0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailTableViewCell.reuseIdentifier, for: indexPath) as? DetailTableViewCell else {
                return UITableViewCell()
            }
            let item = Self.CharacterDetail.allCases[indexPath.row]
            cell.configure(with: item.title, description: item.value(from: self.character))
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailTableViewCell.reuseIdentifier, for: indexPath) as? DetailTableViewCell else {
                return UITableViewCell()
            }
            let episode = self.episodes[indexPath.row]
            let title = episode.episode ?? "N/A"
            let description = episode.name ?? "N/A"
            let date = (episode.air_date ?? "N/A").uppercased()
            cell.configure(with: title, description: description, date: date)
            return cell
        default: return UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 1: return 64.0
        case 2: return 88.0
        default: return 0.0
        }
    }

}

extension DetailsViewController {

    // MARK: - Setup Layouts

    private func setupLayouts() {
        self.setupNavigationBar()
        self.setupBackButton()
        self.setupView()
        self.setupTableView()
    }

    private func setupNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        appearance.shadowColor = .lightGray.withAlphaComponent(0.44)
        self.navigationController?.navigationBar.standardAppearance = appearance
        self.navigationController?.navigationBar.compactAppearance = appearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }

    private func setupBackButton() {
        let chevronImage = UIImage(systemName: "chevron.left")?.withTintColor(.black.withAlphaComponent(0.86), renderingMode: .alwaysOriginal)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: chevronImage, style: .plain, target: self, action: #selector(self.backButtonTapped))
    }

    private func setupView() {
        self.view.backgroundColor = .white
    }

    private func setupTableView() {
        self.view.addSubview(self.tableView)
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0.0),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0.0),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0.0),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0.0)
        ])
        self.tableView.backgroundColor = .clear
        self.tableView.separatorStyle = .none
        self.tableView.sectionHeaderTopPadding = 0.01
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(DetailTableViewCell.self, forCellReuseIdentifier: DetailTableViewCell.reuseIdentifier)
    }

}
