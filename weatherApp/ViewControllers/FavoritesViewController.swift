//
//  FavoritesViewController.swift
//  weatherApp
//
//  Created by Howard Chang on 5/3/20.
//  Copyright © 2020 Howard Chang. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    let favoriteView = FavoritesView()
    
    override func loadView() {
        view = favoriteView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    


}
