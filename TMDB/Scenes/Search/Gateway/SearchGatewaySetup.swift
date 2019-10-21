//
//  SearchGatewaySetup.swift
//  TMDB
//
//  Created by Matheus Cardoso Kuhn on 20/10/19.
//  Copyright © 2019 MDT. All rights reserved.
//

import Foundation

enum SearchGatewaySetup: RequestSetup {
    case searchMovie(query: String, page: Int)

    var url: String {
        return API.URL.base.rawValue + API.Path.search.rawValue
    }
    var cachePolicy: URLRequest.CachePolicy {
        return API.cachePolicy
    }
    var timeoutInterval: TimeInterval {
        return API.timeoutInterval
    }
    var httpMethod: HttpMethod {
        switch self {
        case .searchMovie:
            return .get
        }
    }
    var httpHeaders: [String: String]? {
        switch self {
        case .searchMovie:
            return nil
        }
    }
    var parameters: [String: Encodable]? {
        switch self {
        case .searchMovie(let query, let page):
            return ["api_key": API.token,
                    "language": Locale.preferredLanguages.first,
                    "page": String(page),
                    "query": query]
        }
    }
}
