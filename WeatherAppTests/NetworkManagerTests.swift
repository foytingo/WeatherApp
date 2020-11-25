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
        sut = NetworkManager(apiKey: Constants.apiKey)
        desiredCity = "London"
    }

    override func tearDownWithError() throws {
        sut = nil
        desiredCity = nil
    }

    
    func testNetworkManager_WhenValidApiKeyAndValidCityName_ReturnCurrentWeatherOfDesiredCity() {
        //Arrange
        
        let expectation = self.expectation(description: "getCurrentWeather() method successfully return desiredCity.")
        //Act
        
        sut.getCurrentWeather(city: desiredCity) { (responseModel, error)  in
            
            //Asert
            XCTAssertEqual(responseModel?.location.name, self.desiredCity, "The getCurrentWeather() method should return desired city for successfull request")
            XCTAssertNil(error, "The getCurrentWeather() method shoul return nil error for successful request.")
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
            XCTAssertEqual(error, WAError.invalidApiKey, "The getCurrentWather() method should return invalidApiKey error for invalid api key.")
            XCTAssertNil(responseModel, "The getCurrentWeather() method should return nil responsModel for invalidKey")
            
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
            XCTAssertEqual(error, WAError.emptyApiKey, "The getCurrentWather() method should return emptyApiKey error for empty api key.")
            XCTAssertNil(responseModel, "The getCurrentWeather() method should return nil responsModel for invalidKey")
            
            expectation.fulfill()
        }
        self.wait(for: [expectation], timeout: 5)
    }
    
    func testNetworkManager_WhenInValidCityParameter_ReturnError() {
        //Arrange
        let desiredCity = "asdfsadf"
        let expectation = self.expectation(description: "getCurrentWeather() method return error for invalid city name.")
        
        //Act
        sut.getCurrentWeather(city: desiredCity) { (responseModel, error) in
            
            //Assert
            XCTAssertEqual(error, WAError.invalidCityParameter, "The getCurrentWather() method should return invalidCityParameter error for invalid city.")
            XCTAssertNil(responseModel,"The getCurrentWeather() method should return nil responsModel for invalid city.")
            expectation.fulfill()
        }
        self.wait(for: [expectation], timeout: 5)
    }
    
    func testNetworkManager_WhenEmptyCityParamater_ReturnError() {
        //Arrange
        let desiredCity = ""
        let expectation = self.expectation(description: "getCurrentWeather() method return error for empty city name.")
        
        //Act
        sut.getCurrentWeather(city: desiredCity) { (responseModel, error) in
            
            //Assert
            XCTAssertEqual(error, WAError.emptyCityParameter, "The getCurrentWather() method should return emptyCityParameter error for empty invalid city.")
            XCTAssertNil(responseModel,"The getCurrentWeather() method should return nil responsModel for empty city.")
            expectation.fulfill()
        }
        self.wait(for: [expectation], timeout: 5)
        
    }
    
}
