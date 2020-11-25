//
//  ErrorModel.swift
//  WeatherApp
//
//  Created by Murat Baykor on 25.11.2020.
//

import Foundation

struct ErrorModel: Codable {
    let error: Error
    
}

struct Error: Codable {
    let code: Int
}
