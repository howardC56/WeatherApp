//
//  FavoriteTableViewCell.swift
//  weatherApp
//
//  Created by Howard Chang on 5/4/20.
//  Copyright © 2020 Howard Chang. All rights reserved.
//

import UIKit
import Kingfisher

class FavoriteTableViewCell: UITableViewCell {
    
    public lazy var tableImage: UIImageView = {
              let image = UIImageView()
              image.image = UIImage(systemName: "photo.fill")
              image.layer.borderWidth = 0.5
              image.layer.borderColor = UIColor.black.cgColor
              image.contentMode = .scaleAspectFill
              image.backgroundColor = .white
              image.clipsToBounds = true
              return image
          }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
      super.init(style: style, reuseIdentifier: reuseIdentifier)
      commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        tableImageSetup()
    }
    
    private func tableImageSetup() {
        addSubview(tableImage)
        tableImage.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
    }
    
    public func configureCell(pic: Pic) {
        DispatchQueue.main.async {
            self.tableImage.kf.setImage(with: URL(string: pic.webformatURL))
        }
    }
}
