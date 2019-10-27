//
//  Catalog.swift
//  TMDB
//
//  Created by Matheus Cardoso Kuhn on 12/10/19.
//  Copyright © 2019 MDT. All rights reserved.
//

import Foundation

enum Catalog {
    struct Movie {
        let title: String
        let genre: String
        let releaseDate: Date?
        let posterPath: String
    }
}
