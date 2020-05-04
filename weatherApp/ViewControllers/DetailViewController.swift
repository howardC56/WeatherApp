//
//  DetailViewController.swift
//  weatherApp
//
//  Created by Howard Chang on 5/3/20.
//  Copyright © 2020 Howard Chang. All rights reserved.
//

import UIKit
import DataPersistence

class DetailViewController: UIViewController {

    private var placeName: String?
    private var pickedWeather: DailyDatum?
    let dataPersistence = DataPersistence<FavoriteItem>(filename: "favorites.plist")
    
    init(pickedWeather: DailyDatum, placeName: String) {
        self.placeName = placeName
        self.pickedWeather = pickedWeather
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = placeName
    }
    


}
