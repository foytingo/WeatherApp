//
//  NetworkManagerTests.swift
//  WeatherAppTests
//
//  Created by Murat Baykor on 25.11.2020.
//

import XCTest
@testable import WeatherApp

class NetworkManagerTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testNetworkManager_WhenValidApiKey_ReturnCurrentWeatherOfDesiredCity() {
        //Arrange
        
        let sut = NetworkManager(apiKey: Constants.apiKey)
        let desiredCity = "London"
        let expectation = self.expectation(description: "Network Manager Response Expectation")
        //Act
        
        sut.getCurrentWeather(city: desiredCity) { (responseModel, error)  in
            
            //Asert
            XCTAssertEqual(responseModel?.location.name, desiredCity, "The getCurrentWeather() method should return desired city for successfull request")
            XCTAssertNil(error, "The getCurrentWeather() method shoul return nil error for successful request.")
            expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: 5)
    }

    
    func testNetworkManager_WhenInvalidApiKey_RetunError() {
        //Arrange
        
        let sut = NetworkManager(apiKey: "sasdg234dfg")
        let desiredCity = "London"
        let expectation = self.expectation(description: "Network Manager Expectation")
        
        //Act
        sut.getCurrentWeather(city: desiredCity) { (responseModel, error) in
            
            //Assert
            XCTAssertEqual(error, WAError.invalidApiKey)
            XCTAssertNil(responseModel, "The getCurrentWeather() method should return nil responsModel for invalidKey")
            
            expectation.fulfill()
        }
        self.wait(for: [expectation], timeout: 5)
    }
    
    
    func testNetworkManager_WhenEmptyApiKey_ReturnError() {
        let sut = NetworkManager(apiKey: "")
        let desiredCity = "London"
        let expectation = self.expectation(description: "Network Manager Expectation")
        
        //Act
        sut.getCurrentWeather(city: desiredCity) { (responseModel, error) in
            
            //Assert
            XCTAssertEqual(error, WAError.emptyApiKey)
            XCTAssertNil(responseModel, "The getCurrentWeather() method should return nil responsModel for invalidKey")
            
            expectation.fulfill()
        }
        self.wait(for: [expectation], timeout: 5)
    }
    
}
