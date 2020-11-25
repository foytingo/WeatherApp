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
            
            if let response = response as? HTTPURLResponse, response.statusCode != 200 {
                if response.statusCode == 401 {
                    completion(nil,WAError.apiKeyError)
                }
                return
            }
            
            guard let data = data else {
                //TODO: Handle data error
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let currentWeather = try decoder.decode(WeatherModel
                                                            .self, from: data)
                completion(currentWeather, nil)
            } catch {
                //TODO: competion error
            }
        }
        
        task.resume()
    }
}
