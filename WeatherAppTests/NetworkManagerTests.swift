//
//  NetworkManagerTests.swift
//  WeatherAppTests
//
//  Created by Murat Baykor on 25.11.2020.
//

import XCTest
@testable import WeatherApp

class NetworkManagerTests: XCTestCase {

    var sut: NetworkManager!
    var desiredCity: String!
    
    override func setUpWithError() throws {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession(configuration: config)
        sut = NetworkManager(apiKey: Constants.apiKey, urlSession: urlSession)
        desiredCity = "London"
    }

    override func tearDownWithError() throws {
        sut = nil
        desiredCity = nil
        MockURLProtocol.stubResponse = nil
        MockURLProtocol.error = nil
    }

    
    func testNetworkManager_WhenValidApiKeyAndValidCityName_ReturnCurrentWeatherOfDesiredCity() {
        //Arrange
        let expectation = self.expectation(description: "getCurrentWeather() method successfully return desiredCity.")
        let sut = NetworkManager(apiKey: Constants.apiKey)
        
        //Act
        sut.getCurrentWeather(city: desiredCity) { (responseModel, error)  in
            //Asert
            XCTAssertEqual(responseModel?.location.name, self.desiredCity, "The getCurrentWeather() method did not return desired city for successfull request")
            XCTAssertNil(error, "The getCurrentWeather() method did not return nil error for successful request.")
            
            expectation.fulfill()
        }
        self.wait(for: [expectation], timeout: 5)
    }

    
    func testNetworkManager_WhenInvalidApiKey_RetunError() {
        //Arrange
        let sut = NetworkManager(apiKey: "sasdg234dfg")
        let expectation = self.expectation(description: "getCurrentWeather() method return error for invalid apikey.")
        
        //Act
        sut.getCurrentWeather(city: desiredCity) { (responseModel, error) in
            //Assert
            XCTAssertEqual(error, WAError.invalidApiKey, "The getCurrentWather() method did not return invalidApiKey error for invalid api key.")
            XCTAssertNil(responseModel, "The getCurrentWeather() method did not return nil responsModel for invalidKey")
            
            expectation.fulfill()
        }
        self.wait(for: [expectation], timeout: 5)
    }
    
    
    func testNetworkManager_WhenEmptyApiKey_ReturnError() {
        //Arrange
        let sut = NetworkManager(apiKey: "")
        let expectation = self.expectation(description: "getCurrentWeather() method return error for empty apikey")
        
        //Act
        sut.getCurrentWeather(city: desiredCity) { (responseModel, error) in
            //Assert
            XCTAssertEqual(error, WAError.emptyApiKey, "The getCurrentWather() method did not return emptyApiKey error for empty api key.")
            XCTAssertNil(responseModel, "The getCurrentWeather() method did not return nil responsModel for invalidKey")
            
            expectation.fulfill()
        }
        self.wait(for: [expectation], timeout: 5)
    }
    
    
    func testNetworkManager_WhenInValidCityParameter_ReturnError() {
        //Arrange
        let desiredCity = "asdfsadf"
        let expectation = self.expectation(description: "getCurrentWeather() method return error for invalid city name.")
        sut = NetworkManager(apiKey: Constants.apiKey)
        
        //Act
        sut.getCurrentWeather(city: desiredCity) { (responseModel, error) in
            //Assert
            XCTAssertEqual(error, WAError.invalidCityParameter, "The getCurrentWather() method did not return invalidCityParameter error for invalid city.")
            XCTAssertNil(responseModel,"The getCurrentWeather() method should return nil responsModel for invalid city.")
            
            expectation.fulfill()
        }
        self.wait(for: [expectation], timeout: 5)
    }
    
    func testNetworkManager_WhenEmptyCityParamater_ReturnError() {
        //Arrange
        let desiredCity = ""
        let expectation = self.expectation(description: "getCurrentWeather() method return error for empty city name.")
        sut = NetworkManager(apiKey: Constants.apiKey)
        
        //Act
        sut.getCurrentWeather(city: desiredCity) { (responseModel, error) in
            //Assert
            XCTAssertEqual(error, WAError.emptyCityParameter, "The getCurrentWather() method did not return emptyCityParameter error for empty invalid city.")
            XCTAssertNil(responseModel,"The getCurrentWeather() method did not return nil responsModel for empty city.")
            
            expectation.fulfill()
        }
        self.wait(for: [expectation], timeout: 5)
        
    }
    
    
    func testNetworkManager_WhenDifferentJSONResponseForValidInputs_ReturnError() {
        //Arrange
        let jsonString = "{\"location\":{\"city\":\"London\"}}" //invalid json format
        MockURLProtocol.stubResponse = { request in
            let response = HTTPURLResponse.init(url: request.url!, statusCode: 200, httpVersion: "2.0", headerFields: nil)!
            return (response, jsonString.data(using: .utf8)!)
        }
        let expectation = self.expectation(description: "getCurrentWather() method different JSON format.")
        
        //Act
        sut.getCurrentWeather(city: desiredCity) { (responseModel, error) in
            //Assert
            XCTAssertEqual(error, WAError.invalidResponseModel, "The getCurrentWeather() method did not return invalidResponseModel error for invalid response format.")
            XCTAssertNil(responseModel, "The getCurrentWeather() method did not return nil responsModel for invalid response format.")
            
            expectation.fulfill()
        }
        self.wait(for: [expectation], timeout: 5)
    }
    
    
    func testNetworkManager_WhenDifferentJSONResponsForInvalidInputs_ReturnError() {
        //Arrange
        let jsonString = "{\"error\":{\"codes\":\"2asdf\"}}" //Invalid error json format
        MockURLProtocol.stubResponse = { request in
            let response = HTTPURLResponse.init(url: request.url!, statusCode: 400, httpVersion: "2.0", headerFields: nil)!
            return (response, jsonString.data(using: .utf8)!)
        }
        let expectation = self.expectation(description: "getCurrentWather() method different error JSON format.")
        
        //Act
        sut.getCurrentWeather(city: desiredCity) { (responseModel, error) in
            //Assert
            XCTAssertEqual(error, WAError.invalidErrorResponseModel, "The getCurrentWeather() method did not return invalidErrorResponseModel error for invalid error response format.")
            XCTAssertNil(responseModel, "The getCurrentWeather() method did not return nil responsModel for invalid error response format.")
            
            expectation.fulfill()
                
        }
        self.wait(for: [expectation], timeout: 5)
    }
    
    
    func testNetworkManager_WhenURLRequestFails_ReturnsErrorMessage() {
        //Arrange
        let expectation = self.expectation(description: "A failed request expectation")
        let errorDescription = "A localized description of an error"
        MockURLProtocol.error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: errorDescription])
        
        //Act
        sut.getCurrentWeather(city: desiredCity) { (responseModel, error) in
            //Assert
            XCTAssertEqual(error, WAError.failedRequest(description: errorDescription), "The getCurrentWeather() method did not return an expected error for the Failed Request")
            
            expectation.fulfill()
        }
        self.wait(for: [expectation], timeout: 5)
    }
}
