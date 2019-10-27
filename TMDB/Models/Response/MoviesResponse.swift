//
//  MoviesResponse.swift
//  TMDB
//
//  Created by Matheus Cardoso kuhn on 26/08/2018.
//  Copyright © 2018 MDT. All rights reserved.
//

import Foundation

struct MoviesResponse: Decodable {
    let results: [MovieResponse]?
    let page: Int?
    let totalResults: Int?
    let totalPages: Int?

    enum CodingKeys: String, CodingKey {
        case results
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
    }
}
