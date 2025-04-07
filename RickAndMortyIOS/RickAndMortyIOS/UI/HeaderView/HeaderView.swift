//
//  HeaderView.swift
//  RickAndMortyIOS
//
//  Created by Максим Мирошниченко on 07.04.2025.
//

import Foundation
import UIKit

class HeaderView: UIView {

    // MARK: - Private Properties

    private lazy var titleLabel: UILabel = UILabel()

    // MARK: - Lifecycle

    init(title: String) {
        super.init(frame: .zero)
        self.setupLayouts()
        self.titleLabel.text = title
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension HeaderView {

    // MARK: - Setup Layouts

    private func setupLayouts() {
        self.setupView()
        self.setupTitleLabel()
    }

    private func setupView() {
        self.backgroundColor = .white
    }

    private func setupTitleLabel() {
        self.addSubview(self.titleLabel)
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0.0),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24.0),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24.0)
        ])
        self.titleLabel.font = .systemFont(ofSize: 20, weight: .medium)
        self.titleLabel.textColor = .lightGray
        self.titleLabel.textAlignment = .left
    }

}
