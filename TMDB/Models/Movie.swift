//
//  Movie.swift
//  TMDB
//
//  Created by Matheus Cardoso kuhn on 26/08/2018.
//  Copyright © 2018 MDT. All rights reserved.
//

import UIKit

class Movie: Codable {
    var id: Int?
    var title: String?
    var genre_ids: [Int]?
    var poster_path: String?
    var backdrop_path: String?
    var release_date: String?
    var overview: String?
}
