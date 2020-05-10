//
//  MainView.swift
//  weatherApp
//
//  Created by Howard Chang on 5/3/20.
//  Copyright © 2020 Howard Chang. All rights reserved.
//

import UIKit

class MainView: UIView {

    public lazy var search: UISearchBar = {
        let sb = UISearchBar()
        sb.backgroundColor = .white
        sb.searchBarStyle = .minimal
        sb.keyboardType = .numbersAndPunctuation
        sb.placeholder = "Location ex: 90201 or 100-8111 japan"
        sb.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return sb
    }()

    public lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.itemSize = CGSize(width: frame.width / 3, height: frame.height / 3)
        layout.sectionInset = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.backgroundColor = .systemTeal
        return cv
    }()
    
    override init(frame:CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        backgroundColor = .systemTeal
        searchBarSetup()
        collectionViewSetup()
    }
    
    private func searchBarSetup() {
        addSubview(search)
        search.anchor(top: safeAreaLayoutGuide.topAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0)
    }
    
    private func collectionViewSetup() {
        addSubview(collectionView)
        collectionView.anchor(top: search.bottomAnchor, left: leftAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, right: rightAnchor, paddingLeft: 0, paddingBottom: 60, paddingRight: 0)
    }
}
