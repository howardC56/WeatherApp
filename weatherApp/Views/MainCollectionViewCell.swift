//
//  MainCollectionViewCell.swift
//  weatherApp
//
//  Created by Howard Chang on 5/3/20.
//  Copyright © 2020 Howard Chang. All rights reserved.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {
    
    public lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.layer.cornerRadius = 10
        image.backgroundColor = .white
        image.image = UIImage(systemName: "photo")
        return image
    }()
    
    public lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.backgroundColor = .white
        return label
    }()
    
    public lazy var tempLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.backgroundColor = .white
        label.numberOfLines = 2
        return label
    }()
    
    public func configureCell(weather: DailyDatum) {
        dateLabel.text = Double(weather.time).convertToDate(dateFormat: "EEEE")
        imageView.image = UIImage(systemName: "cloud.sun")
        tempLabel.text = "High: \(weather.temperatureHigh.temperatureFormater()) \nLow: \(weather.temperatureLow.temperatureFormater())"
    }
    
    override init(frame: CGRect) {
              super.init(frame:frame)
              commonSetup()
          }
          
          required init?(coder: NSCoder) {
              fatalError("init(coder:) has not been implemented")
          }
    
    private func commonSetup() {
        layer.cornerRadius = 10
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 5
        layer.shadowOffset = .zero
        layer.shadowOpacity = 0.5
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        backgroundColor = .white
        dateLabelSetup()
        tempLabelSetup()
        imageViewSetup()
    }
    
    private func dateLabelSetup() {
        addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            dateLabel.centerXAnchor.constraint(equalTo: centerXAnchor), dateLabel.heightAnchor.constraint(equalToConstant: 30)])
    }
    
    private func imageViewSetup() {
        addSubview(imageView)
        imageView.anchor(top: dateLabel.bottomAnchor, left: leftAnchor, bottom: tempLabel.topAnchor, right: rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 10, paddingRight: 10)
    }
    
    private func tempLabelSetup() {
        addSubview(tempLabel)
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tempLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            tempLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            tempLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            tempLabel.centerXAnchor.constraint(equalTo: centerXAnchor), tempLabel.heightAnchor.constraint(equalToConstant: 60)])
    }
}
