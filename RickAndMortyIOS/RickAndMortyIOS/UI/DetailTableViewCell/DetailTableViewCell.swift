//
//  DetailTableViewCell.swift
//  RickAndMortyIOS
//
//  Created by Максим Мирошниченко on 07.04.2025.
//

import UIKit

class DetailTableViewCell: UITableViewCell {

    // MARK: - Public Properties

    static let reuseIdentifier = "DetailTableViewCell"

    // MARK: - Private Properties

    private lazy var stackView: UIStackView = UIStackView()
    private lazy var titleLabel: UILabel = UILabel()
    private lazy var descriptionLabel: UILabel = UILabel()
    private lazy var dateLabel: UILabel = UILabel()
    private lazy var delimiterView: UIView = UIView()

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
        self.titleLabel.text = nil
        self.descriptionLabel.text = nil
        self.stackView.removeArrangedSubview(self.descriptionLabel)
        self.dateLabel.text = nil
        self.stackView.removeArrangedSubview(self.dateLabel)
    }

    // MARK: - Public Methods

    func configure(with title: String? = nil, description: String? = nil, date: String? = nil) {
        if let title = title {
            self.titleLabel.text = title.isEmpty ? "N/A" : title
        }
        if let description = description {
            self.descriptionLabel.text = description.isEmpty ? "N/A" : description
            self.stackView.addArrangedSubview(self.descriptionLabel)
        }
        if let date = date {
            self.dateLabel.text = date.isEmpty ? "N/A" : date
            self.stackView.addArrangedSubview(self.dateLabel)
        }
    }

}

extension DetailTableViewCell {

    // MARK: - Setup Layouts

    private func setupLayouts() {
        self.setupContentView()
        self.setupStackView()
        self.setupTitleLabel()
        self.setupDescriptionLabel()
        self.setupDateLabel()
        self.setupDelimiterView()
    }

    private func setupContentView() {
        self.selectionStyle = .none
        self.backgroundColor = UIColor.clear
    }

    private func setupStackView() {
        self.contentView.addSubview(self.stackView)
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.stackView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 12.0),
            self.stackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 40.0),
            self.stackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -40.0),
            self.stackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -12.0)
        ])
        self.stackView.axis = .vertical
        self.stackView.alignment = .leading
        self.stackView.distribution = .fillEqually
        self.stackView.spacing = 0.0
    }

    private func setupTitleLabel() {
        self.titleLabel.font = .systemFont(ofSize: 16, weight: .bold)
        self.titleLabel.textColor = .black.withAlphaComponent(0.86)
        self.stackView.addArrangedSubview(self.titleLabel)
    }

    private func setupDescriptionLabel() {
        self.descriptionLabel.font = .systemFont(ofSize: 16, weight: .regular)
        self.descriptionLabel.textColor = .black.withAlphaComponent(0.6)
    }

    private func setupDateLabel() {
        self.dateLabel.font = .systemFont(ofSize: 10, weight: .medium)
        self.dateLabel.textColor = .black.withAlphaComponent(0.44)
    }

    private func setupDelimiterView() {
        self.contentView.addSubview(self.delimiterView)
        self.delimiterView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.delimiterView.heightAnchor.constraint(equalToConstant: 1.0),
            self.delimiterView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 38.0),
            self.delimiterView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -38.0),
            self.delimiterView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 0.0)
        ])
        self.delimiterView.backgroundColor = .gray.withAlphaComponent(0.12)
    }

}
