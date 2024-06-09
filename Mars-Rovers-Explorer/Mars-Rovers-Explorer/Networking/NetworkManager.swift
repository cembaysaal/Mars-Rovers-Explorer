//
//  NetworkManager.swift
//  Mars-Rovers-Explorer
//
//  Created by Cem Baysal on 9.06.2024.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()

    func fetchRovers(completion: @escaping (Result<[Rover], Error>) -> Void) {
        let url = URL(string: "https://mars-photos.herokuapp.com/api/v1/rovers")!
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                }
                return
            }
            let decoder = JSONDecoder()
            do {
                let roverResponse = try decoder.decode(RoverResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(roverResponse.rovers))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }.resume()
    }

    func fetchLatestPhotos(for roverName: String, completion: @escaping (Result<[Photo], Error>) -> Void) {
        let urlString = "https://mars-photos.herokuapp.com/api/v1/rovers/\(roverName)/latest_photos"
        guard let url = URL(string: urlString) else {
            DispatchQueue.main.async {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            }
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                }
                return
            }
            let decoder = JSONDecoder()
            do {
                let photoResponse = try decoder.decode(PhotoResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(photoResponse.latest_photos))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}
