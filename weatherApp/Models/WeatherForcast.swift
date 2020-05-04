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
    let summary: Summary
    let icon: Icon
    let precipIntensity, precipProbability, temperature, apparentTemperature: Double
    let dewPoint, humidity, pressure, windSpeed: Double
    let windGust: Double
}

enum Icon: String, Codable {
    case clearDay = "clear-day"
    case clearNight = "clear-night"
    case cloudy = "cloudy"
    case partlyCloudyDay = "partly-cloudy-day"
    case partlyCloudyNight = "partly-cloudy-night"
}


enum Summary: String, Codable {
    case clear = "Clear"
    case mostlyCloudy = "Mostly Cloudy"
    case overcast = "Overcast"
    case partlyCloudy = "Partly Cloudy"
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
    let icon: Icon
    let data: [Currently]
}
