//
//  MoviesGatewaySetup.swift
//  TMDB
//
//  Created by Matheus Cardoso Kuhn on 16/10/19.
//  Copyright © 2019 MDT. All rights reserved.
//

import Foundation

enum MoviesGatewaySetup: RequestSetup {

    case genre
    case upcomingMovies(page: Int)

    var url: String {
        switch self {
        case .genre:
            return API.URL.base.rawValue + API.Path.genre.rawValue
        case .upcomingMovies:
            return API.URL.base.rawValue + API.Path.upcoming.rawValue
        }
    }
    var cachePolicy: URLRequest.CachePolicy { return API.cachePolicy }
    var timeoutInterval: TimeInterval { return API.timeoutInterval }
    var httpMethod: HttpMethod { return .get }
    var httpHeaders: [String: String]? { return nil }
    var parameters: [String: Encodable]? {
        switch self {
        case .genre:
            return ["api_key": API.token,
                    "language": Locale.preferredLanguages.first]
        case .upcomingMovies(let page):
            return ["api_key": API.token,
                    "language": Locale.preferredLanguages.first,
                    "page": page]
        }
    }
}
