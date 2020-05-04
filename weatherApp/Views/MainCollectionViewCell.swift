//
//  MainCollectionViewCell.swift
//  weatherApp
//
//  Created by Howard Chang on 5/3/20.
//  Copyright © 2020 Howard Chang. All rights reserved.
//

import UIKit
import Lottie

class MainCollectionViewCell: UICollectionViewCell {
    
    public lazy var imageView: AnimationView = {
        let image = AnimationView()
        image.clipsToBounds = true
        image.layer.cornerRadius = 10
        image.backgroundColor = .white
        image.loopMode = .loop
        image.backgroundBehavior = .pauseAndRestore
        image.contentMode = .scaleAspectFit
        image.shouldRasterizeWhenIdle = true
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
        DispatchQueue.main.async {
            self.dateLabel.text = Double(weather.time).convertToDate(dateFormat: "EEEE")
        let icon = weather.icon.lowercased()
        if icon.contains("clear") {
            self.imageView.animation = Animation.named("clearDay")
        } else if icon.contains("wind") {
            self.imageView.animation = Animation.named("windy-weather")
        } else if icon.contains("rain") {
            self.imageView.animation = Animation.named("rainy-weather")
        } else if icon.contains("drizzle") {
            self.imageView.animation = Animation.named("rainy-weather")
        } else if icon.contains("blizzard") {
            self.imageView.animation = Animation.named("snow-storm-weather")
        } else if icon.contains("snow") {
            self.imageView.animation = Animation.named("snow-storm-weather")
        } else if icon.contains("sunny") {
            self.imageView.animation = Animation.named("clearDay")
        } else if icon.contains("fair") {
            self.imageView.animation = Animation.named("clearDay")
        } else if icon.contains("sleet") {
            self.imageView.animation = Animation.named("snow-storm-weather")
        } else if icon.contains("wintry") {
            self.imageView.animation = Animation.named("snow-storm-weather")
        } else if icon.contains("wind") {
            self.imageView.animation = Animation.named("windy-weather")
        } else if icon.contains("flurries") {
            self.imageView.animation = Animation.named("snow-storm-weather")
        } else if icon.contains("showers") {
            self.imageView.animation = Animation.named("rainy-weather")
        } else if icon.contains("storm") {
            self.imageView.animation = Animation.named("lightning-weather")
        } else if icon.contains("cloudy") {
            self.imageView.animation = Animation.named("cloudy")
        } else if icon.contains("hazy") {
            self.imageView.animation = Animation.named("haze-weather")
            } else if icon.contains("fog") {
            self.imageView.animation = Animation.named("haze-weather")
        } else if icon.contains("smoke") {
            self.imageView.animation = Animation.named("haze-weather")
        } else {
            self.imageView.animation = Animation.named("embarrassed")
        }
            
            self.imageView.play()
            self.tempLabel.text = "High: \(weather.temperatureHigh.temperatureFormater()) \nLow: \(weather.temperatureLow.temperatureFormater())"
    }
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
