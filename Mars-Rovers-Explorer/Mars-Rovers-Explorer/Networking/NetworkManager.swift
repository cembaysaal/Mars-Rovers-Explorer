//
//  NetworkManager.swift
//  Mars-Rovers-Explorer
//
//  Created by Cem Baysal on 9.06.2024.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    private let baseURL = "https://mars-photos.herokuapp.com/api/v1/rovers"

    func fetchRovers(completion: @escaping (Result<[Rover], Error>) -> Void) {
        let url = URL(string: baseURL)!
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                return
            }
            do {
                let roverResponse = try JSONDecoder().decode(RoverResponse.self, from: data)
                completion(.success(roverResponse.rovers))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

    func fetchLatestPhotos(for roverName: String, completion: @escaping (Result<[Photo], Error>) -> Void) {
        let urlString = "\(baseURL)/\(roverName)/latest_photos"
        let url = URL(string: urlString)!
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                return
            }
            do {
                let photoResponse = try JSONDecoder().decode(PhotoResponse.self, from: data)
                completion(.success(photoResponse.latest_photos))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
