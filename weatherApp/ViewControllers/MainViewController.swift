//
//  ViewController.swift
//  weatherApp
//
//  Created by Howard Chang on 5/1/20.
//  Copyright © 2020 Howard Chang. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    let mainView = MainView()
    
    private var zipcode = "11355" {
        didSet {
            mainView.collectionView.reloadData()
        }
    }
    
    private var place: String = "New York" {
        didSet {
            DispatchQueue.main.async {
                self.navigationItem.title = self.place
            }
        }
    }
    
    private var weathers = [DailyDatum]() {
        didSet {
            mainView.collectionView.reloadData()
        }
    }
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.collectionView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: "MainCollectionViewCell")
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        navigationItem.title = place
        mainView.search.delegate = self
        loadData()
    }
    
    private func loadData(zip: String? = nil) {
        if zip == nil {
        if let defaultZipcode = UserDefaults.standard.string(forKey: "zipCode") {
            zipcode = defaultZipcode
        }
        } else if let searchZip = zip {
            zipcode = searchZip
        }
        ZipCodeHelper.getLatLong(fromZipCode: zipcode) { result in
            switch result {
            case .success((let lat, let long, let placeName)):
                DispatchQueue.main.async {
                    self.place = placeName
                    UserDefaults.standard.set(self.zipcode, forKey: "zipCode")
                    self.loadWeather(lat: lat, Long: long)
                }
                
            case .failure(let error):
                self.showAlert(title: "Error", message: "\(error.localizedDescription)")
            }
        }
    }
    
    private func loadWeather(lat: Double, Long: Double) {
        DarkSkysAPIClient.getWeather(lat: lat, long: Long) { [weak self] (result) in
            DispatchQueue.main.async {
            switch result {
            case .failure(let error):
                self?.showAlert(title: "error getting weather", message: error.localizedDescription)
            case .success(let weathers):
                self?.weathers = weathers
            }
        }
        }
    }


}

extension MainViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weathers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let current = weathers[indexPath.row]
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCollectionViewCell", for: indexPath) as? MainCollectionViewCell else {
            fatalError() }
        cell.configureCell(weather: current)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         let pickedWeather = weathers[indexPath.row]
        navigationController?.pushViewController(DetailViewController(pickedWeather: pickedWeather, placeName: place), animated: true)
    }
    
}

extension MainViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if let text = searchBar.text {
            loadData(zip: text)
        } else {
            showAlert(title: "Try Again", message: "Please Check your zipcode")
        }
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.showsCancelButton = true
        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.showsCancelButton = false
    }
}
