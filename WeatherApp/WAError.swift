//
//  WAError.swift
//  WeatherApp
//
//  Created by Murat Baykor on 25.11.2020.
//

import Foundation

enum WAError: String {
    
    case emptyApiKey = "Api key not provided."
    case invalidApiKey = "Api key provided is invalid."
    case invalidResponseCode = "Response code is invalid."
    case invalidCityParameter = "No location found matching your typed city."
    case emptyCityParameter = "City parameter not provided."
}
