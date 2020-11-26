//
//  MockWebService.swift
//  WeatherAppTests
//
//  Created by Murat Baykor on 26.11.2020.
//

import Foundation
@testable import WeatherApp

class MockWebService: WebServiceProtocol {
    
    var isGetCurrentWeatherMethodCalled: Bool = false
    var shouldReturnError: Bool = false
    
    func getCurrentWeather(city: String, completion: @escaping (WeatherModel?, WAError?) -> Void) {
        
        isGetCurrentWeatherMethodCalled = true
        
        if shouldReturnError {
            let error = WAError.failedRequest(description: "Current weather did not get successfuly.")
            completion(nil, error)
        } else {
            let responseModel = WeatherModel(location: Location(name: "London"))
            completion(responseModel, nil)
        }
    }
    

}
