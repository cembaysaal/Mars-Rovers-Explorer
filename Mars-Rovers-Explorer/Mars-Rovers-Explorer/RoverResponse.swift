//
//  RoverResponse.swift
//  Mars-Rovers-Explorer
//
//  Created by Cem Baysal on 9.06.2024.
//

import Foundation

struct RoverResponse: Decodable {
    let rovers: [Rover]
}
