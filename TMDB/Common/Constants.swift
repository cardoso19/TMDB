//
//  Constants.swift
//  TMDB
//
//  Created by Matheus Cardoso Kuhn on 15/10/19.
//  Copyright © 2019 MDT. All rights reserved.
//

import Foundation

enum API {

    static let token: String = "1f54bd990f1cdfb230adb312546d765d"
    static let cachePolicy: URLRequest.CachePolicy = .reloadIgnoringLocalAndRemoteCacheData
    static let timeoutInterval: TimeInterval = 10

    enum URL: String {
        case base = "https://api.themoviedb.org/3"
        case image = "https://image.tmdb.org/t/p/w370_and_h556_bestv2"
    }

    enum Path: String {
        case genre = "/genre/movie/list"
        case search = "/search/movie"
        case upcoming = "/movie/upcoming"
    }
}
