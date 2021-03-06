//
//  WeatherForcast.swift
//  weatherApp
//
//  Created by Howard Chang on 5/3/20.
//  Copyright © 2020 Howard Chang. All rights reserved.
//

import Foundation


struct WeatherForcast: Codable {
    let latitude, longitude: Double
    let timezone: String
    let currently: Currently
    let hourly: Hourly
    let daily: Daily
}

struct Currently: Codable {
    let time: Int
    let summary: String
    let icon: String
    let precipIntensity, precipProbability, temperature, apparentTemperature: Double
    let dewPoint, humidity, pressure, windSpeed: Double
    let windGust: Double
}

struct Daily: Codable {
    let summary: String
    let data: [DailyDatum]
}

struct DailyDatum: Codable {
    let time: Int
    let summary, icon: String
    let sunriseTime, sunsetTime: Int
    let precipProbability: Double
    let temperatureHigh: Double
    let temperatureLow: Double
    let dewPoint, humidity, pressure, windSpeed: Double
    let windGust: Double
}

struct Hourly: Codable {
    let summary: String
    let icon: String
    let data: [Currently]
}
