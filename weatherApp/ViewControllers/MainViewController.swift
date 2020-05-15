//
//  ViewController.swift
//  weatherApp
//
//  Created by Howard Chang on 5/1/20.
//  Copyright © 2020 Howard Chang. All rights reserved.
//

import UIKit
import Lottie
import DataPersistence

class MainViewController: UIViewController {

    let mainView = MainView()
    private let dataPersistence: DataPersistence<Pic>
    private var localName: String = "New York"
    private var imperialUnit: Bool = true
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
    
    init(dataPersistence: DataPersistence<Pic>) {
        self.dataPersistence = dataPersistence
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy private var changeTempUnit: UIBarButtonItem = {
                         [unowned self] in
                return UIBarButtonItem(image: UIImage(named: "temperature"), style: .plain, target: self, action: #selector(configureTempUnit(_:)))
                         }()
    
    @objc func configureTempUnit(_ sender: UIBarButtonItem) {
        imperialUnit.toggle()
        mainView.collectionView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.collectionView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: "MainCollectionViewCell")
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        navigationItem.rightBarButtonItem = changeTempUnit
        navigationItem.title = place
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Bold", size: 28)!]
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
        LocationHelper.getLatLong(fromZipCode: zipcode) { result in
            switch result {
            case .success((let lat, let long, let placeName, let country)):
                DispatchQueue.main.async {
                    self.place = "\(placeName), \(country)"
                    self.localName = placeName
                    UserDefaults.standard.set(self.zipcode, forKey: "zipCode")
                    self.loadWeather(lat: lat, Long: long)
                }
                
            case .failure(let error):
                self.showAlert(title: "Error finding Location", message: "\(error.localizedDescription)")
            }
        }
    }
    
    private func loadWeather(lat: Double, Long: Double) {
        DarkSkysAPIClient.getWeather(lat: lat, long: Long) { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    self?.showAlert(title: "error getting weather", message: "\(error.localizedDescription)")
                case .success(let weathers):
                    self?.weathers = weathers
                    self?.setWeatherGif()
                }
            }
        }
    }
    
    func setWeatherGif() {
        DispatchQueue.main.async {
            if self.weathers[0].icon.contains("clear"){
                self.mainView.imageView.loadGif(asset: "sunny")
            } else if self.weathers[0].icon.contains("wind") {
                self.mainView.imageView.loadGif(asset: "windy")
            } else if self.weathers[0].icon.contains("rain") {
                self.mainView.imageView.loadGif(asset: "rainCloud")
            } else if self.weathers[0].icon.contains("drizzle") {
                self.mainView.imageView.loadGif(asset: "rainCloud")
            } else if self.weathers[0].icon.contains("blizzard") {
                self.mainView.imageView.loadGif(asset: "snowman")
            } else if self.weathers[0].icon.contains("snow") {
                self.mainView.imageView.loadGif(asset: "snowman")
            } else if self.weathers[0].icon.contains("sunny") {
                self.mainView.imageView.loadGif(asset: "sunny")
            } else if self.weathers[0].icon.contains("fair") {
                self.mainView.imageView.loadGif(asset: "sunny")
            } else if self.weathers[0].icon.contains("sleet") {
                self.mainView.imageView.loadGif(asset: "snowman")
            } else if self.weathers[0].icon.contains("wintry") {
                self.mainView.imageView.loadGif(asset: "snowman")
            } else if self.weathers[0].icon.contains("flurries") {
                self.mainView.imageView.loadGif(asset: "snowman")
            } else if self.weathers[0].icon.contains("showers") {
                self.mainView.imageView.loadGif(asset: "rainCloud")
            } else if self.weathers[0].icon.contains("storm") {
                self.mainView.imageView.loadGif(asset: "sunny")
            } else if self.weathers[0].icon.contains("cloudy") {
                self.mainView.imageView.loadGif(asset: "sunCloud")
            } else if self.weathers[0].icon.contains("hazy") {
                self.mainView.imageView.loadGif(asset: "foggy")
            } else if self.weathers[0].icon.contains("fog") {
                self.mainView.imageView.loadGif(asset: "foggy")
            } else if self.weathers[0].icon.contains("smoke") {
                self.mainView.imageView.loadGif(asset: "foggy")
            } else {
                self.mainView.imageView.loadGif(asset: "defaultWeather")
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
        cell.configureCell(weather: current, imperialUnit: imperialUnit)
        return cell
    }
            
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         let pickedWeather = weathers[indexPath.row]
        navigationController?.pushViewController(DetailViewController(pickedWeather: pickedWeather, placeName: place, data: dataPersistence, localName: localName), animated: true)
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
