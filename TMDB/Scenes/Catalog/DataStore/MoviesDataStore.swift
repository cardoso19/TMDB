//
//  MoviesDataStore.swift
//  TMDB
//
//  Created by Matheus Cardoso Kuhn on 11/10/19.
//  Copyright © 2019 MDT. All rights reserved.
//

import UIKit

protocol MoviesDataStore: AnyObject {
    var genres: [GenreResponse] { get set }
    var movies: [MovieResponse] { get set }
}

class MoviesDataStoreImpl: MoviesDataStore {
    var genres: [GenreResponse] = []
    var movies: [MovieResponse] = []
}
