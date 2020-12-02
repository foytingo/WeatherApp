//
//  ViewController.swift
//  WeatherApp
//
//  Created by Murat Baykor on 25.11.2020.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate {
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var currentDegreeLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    
    var presenter: PresenterProtocol?
    
    var desiredCity: String? {
        didSet {
            presenter?.processGetCurrentWeather(city: desiredCity ?? "")
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if presenter == nil {
            let webService = NetworkManager(apiKey: Constants.apiKey)
            presenter = Presenter(webService: webService, delegate: self)
        }
        
        cityNameLabel.text = ""
        currentDegreeLabel.text = ""
        weatherImageView.image = nil
        searchBar.delegate = self
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if searchBar.text != "" {
            desiredCity = searchBar.text?.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: " ", with: "%20")
        }
        searchBar.resignFirstResponder()
        searchBar.setShowsCancelButton(false, animated: true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.text = ""
        searchBar.setShowsCancelButton(false, animated: true)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    
}

extension ViewController: ViewDelegateProtocol {
    func successfullGetCurrentWeather(model: WeatherModel) {
        guard let degree = model.current?.temp_c else { return }
        guard let imageUrlString = model.current?.condition.icon else { return }
        guard let imageUrl = URL(string: "https:\(imageUrlString)") else { return }
        
        DispatchQueue.main.async {
            self.cityNameLabel.text = model.location.name
            self.currentDegreeLabel.text = String(format: "%.0f", degree) + " °C"
        }
        
        self.weatherImageView.load(url: imageUrl)
        
    }
    
    
    func errorHandler(error: WAError) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Error", message: "\(error)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                self.searchBar.text = ""
                self.searchBar.becomeFirstResponder()
            }))
            alert.view.accessibilityIdentifier = "errorAlertDialog"
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
}



