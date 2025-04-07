//
//  ImageHeaderView.swift
//  RickAndMortyIOS
//
//  Created by Максим Мирошниченко on 06.04.2025.
//

import Foundation
import UIKit

class ImageHeaderView: UIView {

    // MARK: - Private Properties

    private lazy var contentView: UIView = UIView()
    private lazy var imageContainerView: UIView = UIView()
    private lazy var imageView: UIImageView = UIImageView()
    private lazy var titleLabel: UILabel = UILabel()

    // MARK: - Lifecycle

    init(imageUrl: String?, title: String?) {
        super.init(frame: .zero)
        self.setupLayouts()
        let placeholderImage = UIImage(named: "character.placeholder")
        if let url = imageUrl {
            self.imageView.fetchImage(from: url, placeholder: placeholderImage)
        } else {
            self.imageView.image = placeholderImage
        }
        self.titleLabel.text = title ?? "N/A"
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension ImageHeaderView {

    // MARK: - Setup Layouts

    private func setupLayouts() {
        self.setupView()
        self.setupContentView()
        self.setupImageContainerView()
        self.setupImageView()
        self.setupTitleLabel()
    }

    private func setupView() {
        self.backgroundColor = .white
    }

    private func setupContentView() {
        self.addSubview(self.contentView)
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.contentView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0.0),
            self.contentView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0.0)
        ])
    }

    private func setupImageContainerView() {
        self.contentView.addSubview(self.imageContainerView)
        self.imageContainerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.imageContainerView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 0.0),
            self.imageContainerView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor, constant: 0.0),
            self.imageContainerView.widthAnchor.constraint(equalToConstant: 152.0),
            self.imageContainerView.heightAnchor.constraint(equalToConstant: 152.0)
        ])
        self.imageContainerView.backgroundColor = .lightGray.withAlphaComponent(0.12)
        self.imageContainerView.layer.cornerRadius = 76.0
    }

    private func setupImageView() {
        self.imageContainerView.addSubview(self.imageView)
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.imageView.topAnchor.constraint(equalTo: self.imageContainerView.topAnchor, constant: 6.0),
            self.imageView.leadingAnchor.constraint(equalTo: self.imageContainerView.leadingAnchor, constant: 6.0),
            self.imageView.trailingAnchor.constraint(equalTo: self.imageContainerView.trailingAnchor, constant: -6.0),
            self.imageView.bottomAnchor.constraint(equalTo: self.imageContainerView.bottomAnchor, constant: -6.0)
        ])
        self.imageView.clipsToBounds = true
        self.imageView.layer.cornerRadius = 70.0
    }

    private func setupTitleLabel() {
        self.contentView.addSubview(self.titleLabel)
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: self.imageContainerView.bottomAnchor, constant: 12.0),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 0.0),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: 0.0),
            self.titleLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 0.0),
            self.titleLabel.heightAnchor.constraint(equalToConstant: 50.0)
        ])
        self.titleLabel.font = .systemFont(ofSize: 32, weight: .regular)
        self.titleLabel.textColor = .black.withAlphaComponent(0.86)
        self.titleLabel.textAlignment = .center
    }

}
