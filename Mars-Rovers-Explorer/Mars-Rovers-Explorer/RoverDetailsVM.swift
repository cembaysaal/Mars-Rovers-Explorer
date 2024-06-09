//
//  RoverDetailsVM.swift
//  Mars-Rovers-Explorer
//
//  Created by Cem Baysal on 9.06.2024.
//

import Foundation

class RoverDetailsVM {
    var rover: Rover
    var latestPhotos: [Photo] = []
    var onPhotosUpdated: (() -> Void)?
    var onError: ((Error) -> Void)?

    init(rover: Rover) {
        self.rover = rover
    }

    func fetchLatestPhotos() {
        NetworkManager.shared.fetchLatestPhotos(for: rover.name) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let photos):
                self.latestPhotos = photos
                self.onPhotosUpdated?()
            case .failure(let error):
                self.onError?(error)
            }
        }
    }
}
