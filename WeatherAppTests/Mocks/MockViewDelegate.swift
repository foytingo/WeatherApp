//
//  MockViewDelegate.swift
//  WeatherAppTests
//
//  Created by Murat Baykor on 26.11.2020.
//

import Foundation
import XCTest
@testable import WeatherApp

class MockViewDelegate: ViewDelegateProtocol {

    
    
    var expectation: XCTestExpectation?
    var successfulGetCurrentWeatherCounter = 0
    var successfullGetCurrentLocationCounter = 0
    var errorHandlerCounter = 0
    var error: WAError?
    
    func successfullGetCurrentWeather(model: WeatherModel) {
        successfulGetCurrentWeatherCounter += 1
        expectation?.fulfill()
    }
    
    
    func errorHandler(error: WAError) {
        errorHandlerCounter += 1
        self.error = error
        expectation?.fulfill()
    }
}
