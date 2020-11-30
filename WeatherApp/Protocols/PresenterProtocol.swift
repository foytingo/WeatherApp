//
//  PresenterProtocol.swift
//  WeatherApp
//
//  Created by Murat Baykor on 30.11.2020.
//

import Foundation

protocol PresenterProtocol: AnyObject {
    init(webService: WebServiceProtocol, delegate: ViewDelegateProtocol)
    func processGetCurrentWeather(city: String)
}
