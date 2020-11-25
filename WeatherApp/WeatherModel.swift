//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Murat Baykor on 25.11.2020.
//

import Foundation

struct WeatherModel: Codable {
    let location: Location
    
}

struct Location: Codable {
    let name: String
}
