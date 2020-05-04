//
//  FavoriteItem.swift
//  weatherApp
//
//  Created by Howard Chang on 5/3/20.
//  Copyright © 2020 Howard Chang. All rights reserved.
//

import Foundation

struct FavoriteItem: Codable & Equatable {
    let imageURL: String
    let id: String
    let time: Int
    let summary, icon: String
    let sunriseTime, sunsetTime: Int
    let precipProbability: Double
    let temperatureHigh: Double
    let temperatureLow: Double
    let dewPoint, humidity, pressure, windSpeed: Double
    let windGust: Double
}
