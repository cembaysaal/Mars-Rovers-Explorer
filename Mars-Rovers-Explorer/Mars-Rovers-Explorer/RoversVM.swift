//
//  RoversVM.swift
//  Mars-Rovers-Explorer
//
//  Created by Cem Baysal on 9.06.2024.
//

import Foundation

class RoversVM {
    var rovers: [Rover] = []
    var onRoversUpdated: (() -> Void)?
    var onError: ((Error) -> Void)?

    func fetchRovers() {
        NetworkManager.shared.fetchRovers { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let rovers):
                self.rovers = rovers
                self.onRoversUpdated?()
            case .failure(let error):
                self.onError?(error)
            }
        }
    }
}
