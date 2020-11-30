//
//  ControllerTests.swift
//  WeatherAppTests
//
//  Created by Murat Baykor on 28.11.2020.
//

import XCTest
@testable import WeatherApp

class ControllerTests: XCTestCase {

    var storyboard: UIStoryboard!
    var sut: ViewController!
    var desiredCity: String!
    
    override func setUpWithError() throws {
        storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(identifier: "ViewController") as ViewController
        sut.loadViewIfNeeded()
        desiredCity = "London"
    }

    override func tearDownWithError() throws {
        storyboard = nil
        sut = nil
        desiredCity = nil
    }

    
    func testViewController_WhenCreated_HasRequiredSearchBarTextFieldIsEmpty() throws {
        //Arrange
        let searchBar = try XCTUnwrap(sut.searchBar, "The searchbar is not connected to an IBOutlet.")
        
        //Act
        
        //Assert
        XCTAssertEqual(searchBar.text, "", "SearchBar textfield was not empty when the view controller initially loaded.")
    }
    
    
    func testViewController_WhenCreated_HasSearchbarDelegate() {
        //Arrange
        //Act
        //Assert
        XCTAssertNotNil(sut.searchBar.delegate, "Searchbar delegate was nill when the view controller initally loaded.")
    }
    
    
    func testViewController_WhenCreated_HasConformSearchbarDelegateProtocol() {
        //Assert
        XCTAssertTrue(sut.conforms(to: UISearchBarDelegate.self), "View controller was not conform to searchbar delegate protocol.")
        XCTAssertTrue(sut.responds(to: #selector(sut.searchBarSearchButtonClicked(_:))), "View controller was not responds searchBarSearchButtonClicked.")
        XCTAssertTrue(sut.responds(to: #selector(sut.searchBarCancelButtonClicked(_:))), "View controller was not responds searchBarCancelButtonClicked.")
    }
    
    
    func testViewController_WhenSearchWithCityName_AfterSearchButtonTapped() {
        //Arrange
        sut.searchBar.text = "London"
        
        //Act
        sut.searchBarSearchButtonClicked(sut.searchBar)
        
        //Assert
        XCTAssertEqual(sut.searchBar.text, sut.desiredCity, "The searchbar text was not equal to desired city.")
    }
    
    func testViewController_WhenSearhWithCityName_AfterSearchButtonTappedTrimmWhiteSpace() {
        //Arrange
        sut.searchBar.text = "London "
        
        //Act
        sut.searchBarSearchButtonClicked(sut.searchBar)
        
        //Assert
        XCTAssertEqual(sut.desiredCity, desiredCity, "The searcbar text was not trimmed after search button tapped.")
    }
    
    func testViewController_WhenSearchWithEmptyCityName_AfterSearchButtonTapped() {
        //Arrange
        sut.searchBar.text = ""
        
        //Act
        sut.searchBarSearchButtonClicked(sut.searchBar)
        
        //Assert
        XCTAssertNil(sut.desiredCity, "The desiredCity was not nil when searchbar text was empty.")
    }
    
    func testViewController_WhenSearchButtonTapped_InvokesGetCurrentWeatherProcess() {
        //Arrange
        sut.searchBar.text = desiredCity
        let mockWebService = MockWebService()
        let mockViewDelegate = MockViewDelegate()
        let mockPresenter = MockPresenter(webService: mockWebService, delegate: mockViewDelegate)
        sut.presenter = mockPresenter
        
        //Act
        sut.searchBarSearchButtonClicked(sut.searchBar)
        
        //Assert
        XCTAssertTrue(mockPresenter.processGetCurrentWeatherCalled, "The processGetCurrentWeatherCalled() method was not called on a Presenter object when the search button was tapped in a Search bar's keyboard.")
    }
    
    
    func testViewController_WhenSearchBegin_ShowCancelButton() {
        //Arrange
        //Act
        sut.searchBarTextDidBeginEditing(sut.searchBar)
        
        //Assert
        XCTAssertTrue(sut.searchBar.showsCancelButton, "The searchbar cancel button did not showed when search begins")
    }
    
    
    func testViewController_SearcbarCancel_HideCancelButton() {
        //Arrange
        //Act
        sut.searchBarCancelButtonClicked(sut.searchBar)
        
        //Assert
        XCTAssertFalse(sut.searchBar.showsCancelButton, "The searchbar cancel button did not hided when tap cancel button.")
    }
    
    
    func testViewController_WhenCreated_HasLabelsIsEmpty() throws {
        //Arrange
        let cityNameLabel = try XCTUnwrap(sut.cityNameLabel, "The cityNameLabel is not connected to an IBOutlet.")
        let currentDegreeLabel = try XCTUnwrap(sut.currentDegreeLabel, "The currentDegreeLabel is not connected to an IBOutlet.")
        
        //Act
        //Assert
        XCTAssertEqual(cityNameLabel.text, "", "The cityNameLabel was not empty when the view controller initially loaded.")
        XCTAssertEqual(currentDegreeLabel.text, "", "The currentDegreeLabel was not empty when the view controller intially loaded.")
    }
    
    func testViewController_WhenCreated_HasWeatherImageViewIsEmpty() throws {
        //Arrange
        let weatherImageView = try XCTUnwrap(sut.weatherImageView, "The weatherImageView is not connected to an IBOutlet.")
        
        //Act
        //Assert
        XCTAssertNil(weatherImageView.image, "The weatherImageView was not empty when the view controller initially loaded.")
        
    }


}
