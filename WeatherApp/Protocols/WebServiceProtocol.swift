//
//  WebServiceProtocol.swift
//  WeatherApp
//
//  Created by Murat Baykor on 26.11.2020.
//

import Foundation

protocol WebServiceProtocol {
    func getCurrentWeather(city: String, completion: @escaping(WeatherModel?, WAError?) -> Void)
}
