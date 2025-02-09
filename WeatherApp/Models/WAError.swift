//
//  WAError.swift
//  WeatherApp
//
//  Created by Murat Baykor on 25.11.2020.
//

import Foundation

enum WAError: LocalizedError, Equatable {
    
    case emptyApiKey
    case invalidApiKey
    case unknownErrorCode
    case invalidCityParameter
    case emptyCityParameter
    case invalidResponseModel
    case invalidErrorResponseModel
    case cantGetCurrentLocation
    case failedRequest(description: String)
    
    var errorDescription: String? {
        switch self {
        case .emptyApiKey:
            return "Api key not provided."
        case .invalidApiKey:
            return "Api key provided is invalid."
        case .unknownErrorCode:
            return "Error code is unknown."
        case .invalidCityParameter:
            return "No location found matching your typed city."
        case .emptyCityParameter:
            return "City parameter not provided."
        case .invalidResponseModel:
            return "The response is invalid format."
        case .invalidErrorResponseModel:
            return "The error response is invalid format."
        case .cantGetCurrentLocation:
            return "The current location cant get with GPS."
        case .failedRequest(let description):
            return description
        }
    }
}
