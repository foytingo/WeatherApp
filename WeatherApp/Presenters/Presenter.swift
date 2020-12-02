//
//  Presenter.swift
//  WeatherApp
//
//  Created by Murat Baykor on 26.11.2020.
//

import Foundation

class Presenter: PresenterProtocol {

    private var webService: WebServiceProtocol
    private weak var delegate: ViewDelegateProtocol?
    
    
    
    required init(webService: WebServiceProtocol, delegate: ViewDelegateProtocol) {
        self.webService = webService
        self.delegate = delegate
 
        
    }
    
    
    func processGetCurrentWeather(city: String) {
        webService.getCurrentWeather(city: city) { [weak self] (responseModel, error) in
            if let error = error {
                self?.delegate?.errorHandler(error: error)
                return
            }
            if let responseModel = responseModel {
                self?.delegate?.successfullGetCurrentWeather(model: responseModel)
                return
            }
        }
        
    }

    
    
}
