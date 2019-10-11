//
//  Movie.swift
//  TMDB
//
//  Created by Matheus Cardoso kuhn on 26/08/2018.
//  Copyright © 2018 MDT. All rights reserved.
//

import UIKit

struct Movie: Decodable {
    let identifier: Int?
    let title: String?
    let genreIDs: [Int]?
    let posterPath: String?
    let backdropPath: String?
    let releaseDate: DateDecodable?
    let overview: String?
    
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
