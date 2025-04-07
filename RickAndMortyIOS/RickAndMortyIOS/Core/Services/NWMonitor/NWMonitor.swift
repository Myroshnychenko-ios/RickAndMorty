//
//  NWMonitor.swift
//  RickAndMortyIOS
//
//  Created by Максим Мирошниченко on 07.04.2025.
//

import Foundation
import Network

class NWMonitor {

    // MARK: - Public Properties

    private(set) var isConnected: Bool = true

    // MARK: - Private Properties

    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NWMonitor")

    // MARK: - Lifecycle

    init() {
        self.monitor.pathUpdateHandler = { path in
            self.isConnected = path.status == .satisfied
        }
        self.monitor.start(queue: self.queue)
    }
    
}
