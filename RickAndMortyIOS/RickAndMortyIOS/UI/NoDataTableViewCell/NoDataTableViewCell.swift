//
//  NoDataTableViewCell.swift
//  RickAndMortyIOS
//
//  Created by Максим Мирошниченко on 07.04.2025.
//

import UIKit

class NoDataTableViewCell: UITableViewCell {

    // MARK: - Public Properties

    static let reuseIdentifier = "NoDataTableViewCell"

    // MARK: - Private Properties

    private lazy var noDataImageView: UIImageView = UIImageView()
    private lazy var noDataLabel: UILabel = UILabel()

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
        self.noDataImageView.image = nil
        self.noDataLabel.text = nil
    }

    // MARK: - Public Methods

    func configure(with title: String) {
        self.noDataImageView.image = UIImage(named: "no.data")
        self.noDataLabel.text = title
    }

}

extension NoDataTableViewCell {

    // MARK: - Setup Layouts

    private func setupLayouts() {
        self.setupContentView()
        self.setupNoDataImageView()
        self.setupNoDataLabel()
    }

    private func setupContentView() {
        self.selectionStyle = .none
        self.backgroundColor = UIColor.clear
    }

    private func setupNoDataImageView() {
        self.contentView.addSubview(self.noDataImageView)
        self.noDataImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.noDataImageView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor, constant: 0.0),
            self.noDataImageView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor, constant: -86.0)
        ])
    }

    private func setupNoDataLabel() {
        self.contentView.addSubview(self.noDataLabel)
        self.noDataLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.noDataLabel.topAnchor.constraint(equalTo: self.noDataImageView.bottomAnchor, constant: 0.0),
            self.noDataLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 24.0),
            self.noDataLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -24.0)
        ])
        self.noDataLabel.font = .systemFont(ofSize: 20, weight: .bold)
        self.noDataLabel.textAlignment = .center
        self.noDataLabel.textColor = .black.withAlphaComponent(0.86)
    }

}
