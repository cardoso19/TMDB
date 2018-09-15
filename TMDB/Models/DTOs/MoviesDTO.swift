//
//  MoviesDTO.swift
//  TMDB
//
//  Created by Matheus Cardoso kuhn on 26/08/2018.
//  Copyright © 2018 MDT. All rights reserved.
//

import Foundation

class MoviesDTO: Codable {
    var results: [Movie]?
    var page: Int?
    var totalResults: Int?
    var totalPages: Int?
    enum CodingKeys: String, CodingKey {
        case results
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
    }
}
