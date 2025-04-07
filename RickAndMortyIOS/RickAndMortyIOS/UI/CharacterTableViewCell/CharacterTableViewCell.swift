//
//  CharacterTableViewCell.swift
//  RickAndMortyIOS
//
//  Created by Максим Мирошниченко on 05.04.2025.
//

import UIKit

class CharacterTableViewCell: UITableViewCell {

    // MARK: - Public Properties

    static let reuseIdentifier = "CharacterTableViewCell"

    // MARK: - Private Properties

    private lazy var containerView: UIView = UIView()
    private lazy var imageUrlView: UIImageView = UIImageView()
    private lazy var stackView: UIStackView = UIStackView()
    private lazy var nameLabel: UILabel = UILabel()
    private lazy var speciesLabel: UILabel = UILabel()

    // MARK: - Lifecycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupLayouts()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageUrlView.image = nil
        self.nameLabel.text = nil
        self.speciesLabel.text = nil
    }

    // MARK: - Public Methods

    func configure(with character: CharacterObject) {
        let placeholderImage = UIImage(named: "character.placeholder")
        if let url = character.image {
            self.imageUrlView.fetchImage(from: url, placeholder: placeholderImage)
        } else {
            self.imageUrlView.image = placeholderImage
        }
        self.nameLabel.text = character.name ?? "N/A"
        self.speciesLabel.text = character.species ?? "N/A"
    }

}

extension CharacterTableViewCell {

    // MARK: - Setup Layouts

    private func setupLayouts() {
        self.setupContentView()
        self.setupContainerView()
        self.setupImageUrlView()
        self.setupStackView()
        self.setupNameLabel()
        self.setupSpeciesLabel()
    }

    private func setupContentView() {
        self.selectionStyle = .none
        self.backgroundColor = UIColor.clear
    }

    private func setupContainerView() {
        self.contentView.addSubview(self.containerView)
        self.containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.containerView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 12.0),
            self.containerView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 24.0),
            self.containerView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -24.0),
            self.containerView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -12.0)
        ])
        self.containerView.backgroundColor = .white
        self.containerView.clipsToBounds = true
        self.containerView.layer.cornerRadius = 4.0
        self.containerView.layer.shadowColor = UIColor.black.cgColor
        self.containerView.layer.shadowOpacity = 0.44
        self.containerView.layer.shadowOffset = .zero
        self.containerView.layer.shadowRadius = 4.0
        self.containerView.layer.masksToBounds = false
    }

    private func setupImageUrlView() {
        self.containerView.addSubview(self.imageUrlView)
        self.imageUrlView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.imageUrlView.topAnchor.constraint(equalTo: self.containerView.topAnchor, constant: 0.0),
            self.imageUrlView.leftAnchor.constraint(equalTo: self.containerView.leftAnchor, constant: 0.0),
            self.imageUrlView.rightAnchor.constraint(equalTo: self.containerView.rightAnchor, constant: 0.0),
            self.imageUrlView.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor, constant: -76.0)
        ])
        self.imageUrlView.layer.cornerRadius = 4.0
        self.imageUrlView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        self.imageUrlView.clipsToBounds = true
    }

    private func setupStackView() {
        self.containerView.addSubview(self.stackView)
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.stackView.topAnchor.constraint(equalTo: self.imageUrlView.bottomAnchor, constant: 12.0),
            self.stackView.leftAnchor.constraint(equalTo: self.containerView.leftAnchor, constant: 16.0),
            self.stackView.rightAnchor.constraint(equalTo: self.containerView.rightAnchor, constant: -16.0),
            self.stackView.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor, constant: -12.0)
        ])
        self.stackView.axis = .vertical
        self.stackView.alignment = .leading
        self.stackView.spacing = 0.0
    }

    private func setupNameLabel() {
        self.nameLabel.font = .systemFont(ofSize: 20, weight: .bold)
        self.nameLabel.textColor = .black.withAlphaComponent(0.86)
        self.stackView.addArrangedSubview(self.nameLabel)
    }

    private func setupSpeciesLabel() {
        self.speciesLabel.font = .systemFont(ofSize: 16, weight: .regular)
        self.speciesLabel.textColor = .black.withAlphaComponent(0.6)
        self.stackView.addArrangedSubview(self.speciesLabel)
    }

}
