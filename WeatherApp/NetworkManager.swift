//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by Murat Baykor on 25.11.2020.
//

import Foundation

class NetworkManager {
    
    private var apiKey: String
    
    init(apiKey: String) {
        self.apiKey = apiKey
    }
    
    func getCurrentWeather(city: String, completion: @escaping(WeatherModel?, WAError?) -> Void) {
        //"https://api.weatherapi.com/v1/current.json?key=166438647dbc4e77af893534202311&q=London"
        let urlString = "\(Constants.baseURL)current.json?key=\(apiKey)&q=\(city)"
        
        guard let url = URL(string: urlString) else {
            //TODO: Create unit test to test that a specific error message is returned is nil
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if error != nil {
                //TODO: Handle error
                return
            }
            
            if let response = response as? HTTPURLResponse {
                if response.statusCode == 200 {
                    if let data = data, let responseModel = try? JSONDecoder().decode(WeatherModel.self, from: data) {
                        completion(responseModel,nil)
                    } else {
                        //TODO: invalid response model error handle
                    }
                } else {
                    if let data = data, let errorModel = try? JSONDecoder().decode(ErrorModel.self, from: data) {
                        switch errorModel.error.code {
                        case 1002:
                            completion(nil,WAError.emptyApiKey)
                        case 2006:
                            completion(nil, WAError.invalidApiKey)
                        default:
                            completion(nil,WAError.invalidResponseCode)
                        }
                    } else {
                        //TODO: invalid error model error handle
                    }
                }
            }
        }
        
        task.resume()
    }
}
