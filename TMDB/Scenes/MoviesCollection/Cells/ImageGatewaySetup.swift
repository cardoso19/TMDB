//
//  ImageGatewaySetup.swift
//  TMDB
//
//  Created by Matheus Cardoso Kuhn on 16/10/19.
//  Copyright © 2019 MDT. All rights reserved.
//

import Foundation

enum ImageGatewaySetup: ImageRequestSetup {

    case download(posterUrl: String)

    var url: String {
        switch self {
        case .download(let posterUrl):
            return API.URL.image.rawValue + posterUrl
        }
    }
    var cachePolicy: URLRequest.CachePolicy { return API.cachePolicy }
}
