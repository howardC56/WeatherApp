//
//  MainTabBarController.swift
//  weatherApp
//
//  Created by Howard Chang on 5/3/20.
//  Copyright © 2020 Howard Chang. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    public lazy var searchViewController: MainViewController = {
        let vc = MainViewController()
        vc.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), selectedImage: UIImage(systemName: "magnifyingglass.circle.fill"))
        return vc
    }()
    
    public lazy var favoritesViewController: FavoritesViewController = {
        let vc = FavoritesViewController()
        vc.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "star"), selectedImage: UIImage(systemName: "star.fill"))
        return vc
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.tintColor = .yellow
        tabBar.backgroundColor = .black
         viewControllers = [UINavigationController(rootViewController: searchViewController), UINavigationController(rootViewController: favoritesViewController)]
    }
    


}
