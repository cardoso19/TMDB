//
//  GenresResponse.swift
//  TMDB
//
//  Created by Matheus Cardoso kuhn on 26/08/2018.
//  Copyright © 2018 MDT. All rights reserved.
//

import Foundation

struct GenresResponse: Decodable {
    let genres: [GenreResponse]
}
