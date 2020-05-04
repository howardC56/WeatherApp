//
//  FavoritesViewController.swift
//  weatherApp
//
//  Created by Howard Chang on 5/3/20.
//  Copyright © 2020 Howard Chang. All rights reserved.
//

import UIKit
import DataPersistence

class FavoritesViewController: UIViewController {
    
    private let dataPersistence: DataPersistence<Pic>
    let favoriteView = FavoritesView()
    private var favorites = [Pic]() {
        didSet {
            favoriteView.tableView.reloadData()
        }
    }
    
    init(dataPersistence: DataPersistence<Pic>) {
        self.dataPersistence = dataPersistence
        super.init(nibName: nil, bundle: nil)
        self.dataPersistence.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = favoriteView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loadFavorites()
        navigationItem.title = "Favorite Pictures"
        favoriteView.tableView.delegate = self
        favoriteView.tableView.dataSource = self
        favoriteView.tableView.register(FavoriteTableViewCell.self, forCellReuseIdentifier: "FavoriteTableViewCell")
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white ]
        navigationController?.navigationBar.barTintColor = .black
    }
    
    private func loadFavorites() {
        do {
            favorites = try dataPersistence.loadItems().reversed()
        } catch {
            showAlert(title: "failed to load favorites", message: "\(error.localizedDescription)")
        }
    }


}

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favorites.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteTableViewCell", for: indexPath) as? FavoriteTableViewCell else {
            fatalError("could not downcast to SearchViewTableViewCell")
        }
        let each = favorites[indexPath.row]
        cell.configureCell(pic: each)
        cell.isUserInteractionEnabled = false
        return cell
    }
    
}

extension FavoritesViewController: DataPersistenceDelegate {
    func didSaveItem<T>(_ persistenceHelper: DataPersistence<T>, item: T) where T : Decodable, T : Encodable, T : Equatable {
        loadFavorites()
    }
    
    func didDeleteItem<T>(_ persistenceHelper: DataPersistence<T>, item: T) where T : Decodable, T : Encodable, T : Equatable {
        loadFavorites()
    }
}

