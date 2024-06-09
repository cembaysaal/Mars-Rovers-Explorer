//
//  Photo.swift
//  Mars-Rovers-Explorer
//
//  Created by Cem Baysal on 9.06.2024.
//

import Foundation

struct Photo: Decodable {
    let id: Int
    let sol: Int
    let camera: Camera
    let img_src: String
    let earth_date: String
    let rover: Rover
}

struct PhotoResponse: Decodable {
    let latest_photos: [Photo]
}
