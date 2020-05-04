//
//  PixPicAPIClient.swift
//  weatherApp
//
//  Created by Howard Chang on 5/3/20.
//  Copyright © 2020 Howard Chang. All rights reserved.
//

import Foundation
import NetworkHelper

struct PhotoApiClient {
    static func getPhotos(search: String, completion: @escaping (Result<[Pic], AppError>)-> ()) {
        
        let search = search.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        let endpoint = "https://pixabay.com/api/?key=\(APIKey.pixabay)&q=\(search)"
        
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
                    let results = try JSONDecoder().decode(PixPic.self, from: data)
                    let photos = results.hits
                    completion(.success(photos))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
        
    }
}
