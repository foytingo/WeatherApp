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
    
    var desiredCity: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cityNameLabel.text = ""
        currentDegreeLabel.text = ""
        weatherImageView.image = nil
        searchBar.delegate = self
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if searchBar.text != "" {
            desiredCity = searchBar.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.setShowsCancelButton(false, animated: true)
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }

    
}

