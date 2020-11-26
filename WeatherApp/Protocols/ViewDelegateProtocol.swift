//
//  ViewDelegateProtocol.swift
//  WeatherApp
//
//  Created by Murat Baykor on 26.11.2020.
//

import Foundation

protocol ViewDelegateProtocol: class {
    func successfullGetCurrentWeather()
    func errorHandler(error: WAError)
}
