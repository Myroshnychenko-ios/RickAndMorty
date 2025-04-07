//
//  UIImageView.swift
//  RickAndMortyIOS
//
//  Created by Максим Мирошниченко on 05.04.2025.
//

import Foundation
import UIKit

extension UIImageView {

    func fetchImage(from imageUrl: String, placeholder: UIImage? = nil) {
        let cache = NSCache<NSString, UIImage>()
        if let cachedImage = cache.object(forKey: imageUrl as NSString) {
            self.image = cachedImage
            return
        }
        guard let url = URL(string: imageUrl) else {
            self.image = placeholder
            return
        }
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        activityIndicator.startAnimating()
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data, let image = UIImage(data: data) else {
                DispatchQueue.main.async {
                    self.image = placeholder
                    activityIndicator.stopAnimating()
                    activityIndicator.removeFromSuperview()
                }
                return
            }
            cache.setObject(image, forKey: imageUrl as NSString)
            DispatchQueue.main.async {
                self.image = image
                activityIndicator.stopAnimating()
                activityIndicator.removeFromSuperview()
            }
        }.resume()
    }

}
