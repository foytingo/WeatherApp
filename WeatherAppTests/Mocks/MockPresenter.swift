//
//  MockPresenter.swift
//  WeatherAppTests
//
//  Created by Murat Baykor on 30.11.2020.
//

import Foundation
@testable import WeatherApp

class MockPresenter: PresenterProtocol {
    
    var processGetCurrentWeatherCalled: Bool = false
    
    required init(webService: WebServiceProtocol, delegate: ViewDelegateProtocol) {
        //TODO
    }
    
    func processGetCurrentWeather(city: String) {
        processGetCurrentWeatherCalled = true
    }
}
