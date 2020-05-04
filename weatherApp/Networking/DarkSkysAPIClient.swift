//
//  DarkSkysAPIClient.swift
//  weatherApp
//
//  Created by Howard Chang on 5/3/20.
//  Copyright © 2020 Howard Chang. All rights reserved.
//

import Foundation
import NetworkHelper

struct DarkSkysAPIClient {
    static func getWeather(lat: Double, long: Double, completion: @escaping (Result<[DailyDatum], AppError>)-> ()) {
           
        let endpoint = "https://api.darksky.net/forecast/\(APIKey.darkSky)/\(lat),\(long)"
           
           guard let url = URL(string: endpoint) else {
               completion(.failure(.badURL(endpoint)))
               return
           }
           
           let request = URLRequest(url: url)
           
           NetworkHelper.shared.performDataTask(with: request) { (result) in
               switch result {
               case .failure(let appError):
                   completion(.failure(.networkClientError(appError)))
               case .success(let data):
                   do {
                       let results = try JSONDecoder().decode(WeatherForcast.self, from: data)
                    let weathers = results.daily.data
                       completion(.success(weathers))
                   } catch {
                       completion(.failure(.decodingError(error)))
                   }
               }
           }
           
       }
}
