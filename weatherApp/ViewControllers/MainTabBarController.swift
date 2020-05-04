//
//  MainTabBarController.swift
//  weatherApp
//
//  Created by Howard Chang on 5/3/20.
//  Copyright © 2020 Howard Chang. All rights reserved.
//

import UIKit
import DataPersistence

class MainTabBarController: UITabBarController {
    
   private let dataPersistence = DataPersistence<Pic>(filename: "favorites.plist")
    
    public lazy var searchViewController: UINavigationController = {
        let vc = UINavigationController(rootViewController: MainViewController(dataPersistence: dataPersistence))
        vc.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), selectedImage: UIImage(systemName: "magnifyingglass.circle.fill"))
        return vc
    }()
    
    public lazy var favoritesViewController: UINavigationController = {
        let vc = UINavigationController(rootViewController: FavoritesViewController(dataPersistence: dataPersistence))
        vc.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "star"), selectedImage: UIImage(systemName: "star.fill"))
        return vc
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.tintColor = .white
        tabBar.barTintColor = .black
        viewControllers = [searchViewController, favoritesViewController]
    }
    


}
