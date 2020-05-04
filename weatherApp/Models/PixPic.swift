//
//  PixPic.swift
//  weatherApp
//
//  Created by Howard Chang on 5/3/20.
//  Copyright © 2020 Howard Chang. All rights reserved.
//

import Foundation

struct PixPic: Codable {
    let hits: [Pic]
}


struct Pic: Codable & Equatable {
    let id: Int
    let pageURL: String
    let webformatURL: String
    let largeImageURL: String
}

