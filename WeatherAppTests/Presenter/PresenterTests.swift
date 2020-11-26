//
//  PresenterTests.swift
//  WeatherAppTests
//
//  Created by Murat Baykor on 26.11.2020.
//

import XCTest
@testable import WeatherApp

class PresenterTests: XCTestCase {

    var desiredCity: String!
    var mockWebservice: MockWebService!
    var sut: Presenter!
    var mockViewDelegate: MockViewDelegate!
    
    override func setUpWithError() throws {
        desiredCity = "London"
        mockWebservice = MockWebService()
        mockViewDelegate = MockViewDelegate()
        sut = Presenter(webService: mockWebservice, delegate: mockViewDelegate)
    }

    override func tearDownWithError() throws {
        desiredCity = nil
        mockWebservice = nil
        mockViewDelegate = nil
        sut = nil
    }
    
    
    func testPressenter_WhenGivenValidInput_ShouldCallGetCurrentWeather() {
        //Arrange
        //Act
        sut.processGetCurrentWeather(city: desiredCity)
     
        //Assert
        XCTAssertTrue(mockWebservice.isGetCurrentWeatherMethodCalled, "The getCurrentWeather() method was not called in the WebService class..")
    }
    

    func testPresenter_WhenGetCurrentWeatherOperationSuccessful_CallsSuccessOnViewDelegate() {
        //Arrange
        let successExpectation = expectation(description: "Expected the successsful() method to be called")
        mockViewDelegate.expectation = successExpectation
        
        //Act
        sut.processGetCurrentWeather(city: desiredCity)
        self.wait(for: [successExpectation], timeout: 5)
        
        //Asssert
        XCTAssertEqual(mockViewDelegate.successfulSignupCounter, 1, "The successfullgetCurrentWeather() method was called more than one.")
    }
    
    
    func testPresenter_WhenGetCurrentWeatherOperationFails_CallsErrorOnViewDelegate() {
        //Arrange
        let errorExpectation = expectation(description: "Expected the errrorHandler() method to be called")
        mockViewDelegate.expectation = errorExpectation
        mockWebservice.shouldReturnError = true
        
        //Act
        sut.processGetCurrentWeather(city: desiredCity)
        self.wait(for: [errorExpectation], timeout: 5)
        
        //Assert
        XCTAssertEqual(mockViewDelegate.successfulSignupCounter, 0, "The succesfullGetCurrentWeather() was called.")
        XCTAssertEqual(mockViewDelegate.errorHandlerCounter, 1, "The errorHandle() method called more than one.")
        XCTAssertNotNil(mockViewDelegate.error, "The errorHand() method did not called so error is nil.")
    }
}
