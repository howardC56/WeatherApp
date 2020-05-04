//
//  FavoritesView.swift
//  weatherApp
//
//  Created by Howard Chang on 5/3/20.
//  Copyright © 2020 Howard Chang. All rights reserved.
//

import UIKit

class FavoritesView: UIView {
    
    public lazy var tableView: UITableView = {
           let tableV = UITableView()
           tableV.rowHeight = 200
           tableV.backgroundColor = .white
           return tableV
       }()
    
    override init(frame:CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        tableViewSetup()
    }
    
    private func tableViewSetup() {
        addSubview(tableView)
        tableView.anchor(top: safeAreaLayoutGuide.topAnchor, left: leftAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, right: rightAnchor)
    }

}
