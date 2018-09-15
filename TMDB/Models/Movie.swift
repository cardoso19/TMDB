//
//  Movie.swift
//  TMDB
//
//  Created by Matheus Cardoso kuhn on 26/08/2018.
//  Copyright © 2018 MDT. All rights reserved.
//

import UIKit

class Movie: Codable {
    var identifier: Int?
    var title: String?
    var genreIDs: [Int]?
    var posterPath: String?
    var backdropPath: String?
    var releaseDate: String?
    var overview: String?
    enum CodingKeys: String, CodingKey {
        case identifier
        case title
        case genreIDs = "genre_ids"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case releaseDate = "release_date"
        case overview
    }
}
