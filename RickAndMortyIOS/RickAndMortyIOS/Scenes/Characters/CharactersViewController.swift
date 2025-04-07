//
//  CharactersViewController.swift
//  RickAndMortyIOS
//
//  Created by Максим Мирошниченко on 04.04.2025.
//

import UIKit

protocol CharactersViewControllerProtocol: AnyObject {

    func displayCharacters(_ viewModel: CharactersModel.GetCharacters.ViewModel)

}

class CharactersViewController: UIViewController {

    // MARK: - VIP Properties

    var interactor: CharactersInteractorProtocol?
    var router: CharactersRouterProtocol?

    // MARK: - Private Properties

    private lazy var tableView: UITableView = UITableView()
    private let refreshControl = UIRefreshControl()

    private var characters: [CharacterObject] = []
    private var isLast: Bool = true

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupLayouts()
        self.interactor?.getCharacters(with: CharactersModel.GetCharacters.Request())
    }

    // MARK: - Private Methods

    @objc private func filterButtonTapped() {
        print("Filter button tapped")
    }

    @objc private func refreshCharacters() {
        self.characters = []
        self.interactor?.getCharacters(with: CharactersModel.GetCharacters.Request(page: 1))
    }

}

extension CharactersViewController: CharactersViewControllerProtocol {

    // MARK: - CharactersViewControllerProtocol

    func displayCharacters(_ viewModel: CharactersModel.GetCharacters.ViewModel) {
        self.characters.append(contentsOf: viewModel.characters)
        self.isLast = viewModel.isLast
        self.tableView.reloadData()
        self.refreshControl.endRefreshing()
        self.interactor?.save(self.characters)
    }

}

extension CharactersViewController: UITableViewDataSource, UITableViewDelegate {

    // MARK: - UITableViewDataSource / UITableViewDelegate

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.characters.count == 0 ? 1 : self.characters.count + (self.isLast ? 0 : 1)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == self.characters.count, !self.isLast {
            return 84.0
        }
        return self.characters.count == 0 ? tableView.frame.height - 48.0 : tableView.frame.width + 52.0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == self.characters.count, !self.isLast {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ButtonTableViewCell.reuseIdentifier, for: indexPath) as? ButtonTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(with: "LOAD MORE")
            cell.onButtonTapped = { [weak self] in
                guard let self = self else { return }
                self.interactor?.getCharacters(with: CharactersModel.GetCharacters.Request())
            }
            return cell
        }
        if self.characters.count != 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CharacterTableViewCell.reuseIdentifier, for: indexPath) as? CharacterTableViewCell else {
                return UITableViewCell()
            }
            let characters = self.characters[indexPath.row]
            cell.configure(with: characters)
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: NoDataTableViewCell.reuseIdentifier, for: indexPath) as? NoDataTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(with: "No Data")
            return cell
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == self.characters.count, !self.isLast {
            return
        }
        let character = self.characters[indexPath.row]
        self.router?.showDetails(with: character)
    }

}

extension CharactersViewController {

    // MARK: - Setup Layouts

    private func setupLayouts() {
        self.setupNavigationBar()
        self.setupLogo()
//        self.setupFilterButton()
        self.setupView()
        self.setupTableView()
        self.setupRefreshControl()
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

    private func setupLogo() {
        let logoImage = UIImage(named: "logo")
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: logoImage, style: .plain, target: self, action: nil)
        self.navigationItem.leftBarButtonItem?.isEnabled = false
    }

    private func setupFilterButton() {
        let filterImage = UIImage(systemName: "line.3.horizontal.decrease")?.withTintColor(.black.withAlphaComponent(0.86), renderingMode: .alwaysOriginal)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: filterImage, style: .plain, target: self, action: nil)
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
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(NoDataTableViewCell.self, forCellReuseIdentifier: NoDataTableViewCell.reuseIdentifier)
        self.tableView.register(CharacterTableViewCell.self, forCellReuseIdentifier: CharacterTableViewCell.reuseIdentifier)
        self.tableView.register(ButtonTableViewCell.self, forCellReuseIdentifier: ButtonTableViewCell.reuseIdentifier)
    }

    private func setupRefreshControl() {
        self.tableView.refreshControl = self.refreshControl
        self.refreshControl.tintColor = .gray
        self.refreshControl.addTarget(self, action: #selector(self.refreshCharacters), for: .valueChanged)
    }

}
