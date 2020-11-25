//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by Murat Baykor on 25.11.2020.
//

import Foundation

class NetworkManager {
    
    private var apiKey: String
    private var urlSession: URLSession
    
    
    init(apiKey: String, urlSession: URLSession = .shared) {
        self.apiKey = apiKey
        self.urlSession = urlSession
    }
    
    
    func getCurrentWeather(city: String, completion: @escaping(WeatherModel?, WAError?) -> Void) {

        let urlString = "\(Constants.baseURL)current.json?key=\(apiKey)&q=\(city)"
        
        let url = URL(string: urlString)!
        
        let task = urlSession.dataTask(with: url) { (data, response, error) in
            
            if let requestError = error {
                completion(nil, WAError.failedRequest(description: requestError.localizedDescription))
                return
            }
            
            if let response = response as? HTTPURLResponse {
                if response.statusCode == 200 {
                    if let data = data, let responseModel = try? JSONDecoder().decode(WeatherModel.self, from: data) {
                        completion(responseModel,nil)
                    } else {
                        completion(nil,WAError.invalidResponseModel)
                    }
                } else {
                    if let data = data, let errorModel = try? JSONDecoder().decode(ErrorModel.self, from: data) {
                        switch errorModel.error.code {
                        case 1002:
                            completion(nil,WAError.emptyApiKey)
                        case 2006:
                            completion(nil, WAError.invalidApiKey)
                        case 1006:
                            completion(nil, WAError.invalidCityParameter)
                        case 1003:
                            completion(nil, WAError.emptyCityParameter)
                        default:
                            completion(nil,WAError.invalidResponseCode)
                        }
                    } else {
                        completion(nil,WAError.invalidErrorResponseModel)
                    }
                }
            }
        }
        
        task.resume()
    }
}
