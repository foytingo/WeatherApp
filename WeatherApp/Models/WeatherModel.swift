//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Murat Baykor on 25.11.2020.
//

import Foundation

struct WeatherModel: Codable {
    let location: Location
    let current: Current?
}

struct Location: Codable {
    let name: String
}

struct Current: Codable {
    let temp_c: Double
    let condition: Condition
}

struct Condition: Codable {
    let icon: String
}
