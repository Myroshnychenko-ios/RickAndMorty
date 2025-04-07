//
//  ButtonTableViewCell.swift
//  RickAndMortyIOS
//
//  Created by Максим Мирошниченко on 05.04.2025.
//

import UIKit

class ButtonTableViewCell: UITableViewCell {

    // MARK: - Public Properties

    static let reuseIdentifier = "ButtonTableViewCell"

    var onButtonTapped: (() -> Void)?

    // MARK: - Private Properties

    private lazy var button: UIButton = UIButton(type: .system)

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
    }

    // MARK: - Public Methods

    func configure(with title: String) {
        self.button.setTitle(title, for: .normal)
    }

    // MARK: - Private Methods

    @objc private func buttonTapped() {
        self.onButtonTapped?()
    }

}

extension ButtonTableViewCell {

    // MARK: - Setup Layouts

    private func setupLayouts() {
        self.setupContentView()
        self.setupButton()
    }

    private func setupContentView() {
        self.selectionStyle = .none
        self.backgroundColor = UIColor.clear
    }

    private func setupButton() {
        self.contentView.addSubview(self.button)
        self.button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.button.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 24.0),
            self.button.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor, constant: 0.0),
            self.button.heightAnchor.constraint(equalToConstant: 36.0),
            self.button.widthAnchor.constraint(equalToConstant: 146.0)
        ])
        self.button.setTitleColor(.blue, for: .normal)
        self.button.backgroundColor = .white
        self.button.layer.cornerRadius = 4.0
        self.button.layer.shadowColor = UIColor.black.cgColor
        self.button.layer.shadowOpacity = 0.44
        self.button.layer.shadowOffset = .zero
        self.button.layer.shadowRadius = 4.0
        self.button.layer.masksToBounds = false
        self.button.addTarget(self, action: #selector(self.buttonTapped), for: .touchUpInside)
    }

}
