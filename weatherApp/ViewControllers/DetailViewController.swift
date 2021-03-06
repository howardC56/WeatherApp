//
//  DetailViewController.swift
//  weatherApp
//
//  Created by Howard Chang on 5/3/20.
//  Copyright © 2020 Howard Chang. All rights reserved.
//

import UIKit
import DataPersistence
import Kingfisher


class DetailViewController: UIViewController {
    
    let detailView = DetailView()
    private var placeName: String?
    private var pickedWeather: DailyDatum?
    private let dataPersistence: DataPersistence<Pic>
    private var picture: Pic?
    private var localName: String?
    
    override func loadView() {
        view = detailView
    }
    
    init(pickedWeather: DailyDatum, placeName: String, data: DataPersistence<Pic>, localName: String) {
        self.placeName = placeName
        self.pickedWeather = pickedWeather
        self.dataPersistence = data
        self.localName = localName
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = placeName
        navigationItem.rightBarButtonItem = favorite
        loadPic()
        configureDetails()
    }
    
    private func loadPic() {
        if let placeName = localName {
        PhotoApiClient.getPhotos(search: placeName) { [weak self] (result) in
            DispatchQueue.main.async {
            switch result {
            case .failure(let error):
                self?.showAlert(title: "Check Place Name", message: "\(error.localizedDescription) \(error)")
            case .success(let pics):
                guard !pics.isEmpty else {
                    self?.detailView.imageView.image = UIImage(systemName: "photo.fill")
                    return
                }
                let random = pics.randomElement() ?? pics[0]
                let picture = random.webformatURL
                self?.detailView.imageView.kf.setImage(with: URL(string: picture))
                self?.picture = random
                self?.ifFavorited(pic: random)
            }
        }
            }
    }
    }
    
      lazy private var favorite: UIBarButtonItem = {
                      [unowned self] in
             return UIBarButtonItem(image: UIImage(systemName: "star"), style: .plain, target: self, action: #selector(configureFavorites(_:)))
                      }()
      
    @objc private func configureFavorites(_ sender: UIBarButtonItem) {
        if let picture = picture {
            DispatchQueue.main.async {
                if self.dataPersistence.hasItemBeenSaved(picture) {
                    self.favorite.image = UIImage(systemName: "star")
                    
                    if let index = try? self.dataPersistence.loadItems().firstIndex(of: picture) {
                        do {
                            try self.dataPersistence.deleteItem(at: index)
                        } catch {
                            self.showAlert(title: "Failed to Delete", message: "\(error.localizedDescription)")
                        }
                    }
                } else {
                    do {
                        self.favorite.image = UIImage(systemName: "star.fill")
                        try self.dataPersistence.createItem(picture)
                    } catch {
                        self.showAlert(title: "Failed to Add", message: "\(error.localizedDescription)")
                    }
                }
            }
        }
    }
    
    private func ifFavorited(pic: Pic) {
        DispatchQueue.main.async {
            if self.dataPersistence.hasItemBeenSaved(pic) {
                self.favorite.image = UIImage(systemName: "star.filled")
        } else {
                self.favorite.image = UIImage(systemName: "star")
        }
        }
    }
    
    private func configureDetails() {
        DispatchQueue.main.async {
            if let picked = self.pickedWeather {
                let highCelsius = picked.temperatureHigh.fahrenheit.converted(to: .celsius).value
                let lowCelsius = picked.temperatureLow.fahrenheit.converted(to: .celsius).value
                let windKMP = picked.windSpeed.milesPerHour.converted(to: .kilometersPerHour).value
                self.detailView.descriptionLabel.attributedText =
                NSMutableAttributedString()
                .normal("\(picked.summary)\n\n")
                .bold("DATE\n")
                .normal("\(Double(picked.time).convertToDate(dateFormat: "EEEE, MMM d, yyyy"))\n\n")
                .bold("HIGH\n")
                .normal("\(picked.temperatureHigh.temperatureFormater(unit: UnitTemperature.fahrenheit))  |  \(highCelsius.temperatureFormater(unit: .celsius))\n\n")
                .bold("LOW\n")
                .normal("\(picked.temperatureLow.temperatureFormater(unit: UnitTemperature.fahrenheit))  |  \(lowCelsius.temperatureFormater(unit: .celsius))\n\n")
                .bold("WIND SPEED\n")
                .normal("\(picked.windSpeed.speedFormater(unit: UnitSpeed.milesPerHour))  |   \(windKMP.speedFormater(unit: .kilometersPerHour))\n\n")
                .bold("DEW POINT\n")
                .normal("\(picked.dewPoint)\n\n")
                .bold("HUMIDITY\n")
                .normal("\(picked.humidity * 100)%\n\n")
                .bold("CHANCE OF RAIN\n")
                .normal("\(picked.precipProbability * 100)%\n")
                
//                "\(picked.summary) \nDATE: \n\(Double(picked.time).convertToDate(dateFormat: "EEEE, MMM d, yyyy")) \nHIGH: \n\(picked.temperatureHigh.temperatureFormater(unit: UnitTemperature.fahrenheit)) / \(highCelsius.temperatureFormater(unit: .celsius)) \nLOW: \n\(picked.temperatureLow.temperatureFormater(unit: UnitTemperature.fahrenheit)) / \(lowCelsius.temperatureFormater(unit: .celsius)) \nWIND SPEED: \n\(picked.windSpeed.speedFormater(unit: UnitSpeed.milesPerHour)) / \(windKMP.speedFormater(unit: .kilometersPerHour)) \nDEW POINT: \n\(picked.dewPoint) \nHUMIDITY: \n\(picked.humidity) \nCHANCE OF RAIN: \n\(picked.precipProbability * 100)%"
    }
    }
}
}
