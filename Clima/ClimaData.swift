//
//  ClimaData.swift
//  Clima
//
//  Created by Mac8 on 20/11/20.
//  Copyright © 2020 Arpan. All rights reserved.
//

import Foundation

struct ClimaData: Decodable {
 
    let name: String
    let cod: Int
    let main: Main
    let weather: [Weather]
    let coord: Coord
    
    
}

struct Main: Decodable {
    let temp: Double
    let humidity: Int
}

struct Weather: Decodable {
    let description: String
}

struct Coord: Decodable {
    let lat: Double
    let lon: Double
}
