//
//  NetworkManager.swift
//  Mars-Rovers-Explorer
//
//  Created by Cem Baysal on 9.06.2024.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()

    func fetchRovers(completion: @escaping ([Rover]?) -> Void) {
        let url = URL(string: "https://mars-photos.herokuapp.com/api/v1/rovers")!
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                completion(nil)
                return
            }
            let decoder = JSONDecoder()
            do {
                let roverResponse = try decoder.decode(RoverResponse.self, from: data)
                completion(roverResponse.rovers)
            } catch {
                completion(nil)
            }
        }.resume()
    }

    func fetchLatestPhotos(for roverName: String, completion: @escaping ([Photo]?) -> Void) {
        let urlString = "https://mars-photos.herokuapp.com/api/v1/rovers/\(roverName)/latest_photos"
        let url = URL(string: urlString)!
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                completion(nil)
                return
            }
            let decoder = JSONDecoder()
            do {
                let photoResponse = try decoder.decode(PhotoResponse.self, from: data)
                completion(photoResponse.latest_photos)
            } catch {
                completion(nil)
            }
        }.resume()
    }
}
