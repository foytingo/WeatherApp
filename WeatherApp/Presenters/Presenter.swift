//
//  Presenter.swift
//  WeatherApp
//
//  Created by Murat Baykor on 26.11.2020.
//

import Foundation

class Presenter {
    
    private var webService: WebServiceProtocol
    private weak var delegate: ViewDelegateProtocol?
    
    init(webService: WebServiceProtocol, delegate: ViewDelegateProtocol) {
        self.webService = webService
        self.delegate = delegate
    }
    
    
    func processGetCurrentWeather(city: String) {
        
        webService.getCurrentWeather(city: city) { [weak self] (responseModel, error) in
            if let error = error {
                self?.delegate?.errorHandler(error: error)
                return
            }
            if let _ = responseModel {
                self?.delegate?.successfullGetCurrentWeather()
                return
            }
        }
        
    }
    
    
}
