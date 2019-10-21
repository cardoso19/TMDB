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
    var currentPage: Int { get set }
    var totalPages: Int { get set }
    var isFetchingMovies: Bool { get set }
}

class MoviesDataStoreImpl: MoviesDataStore {
    var genres: [GenreResponse] = []
    var movies: [MovieResponse] = []
    var currentPage: Int = 0
    var totalPages: Int = 0
    var isFetchingMovies: Bool = false
}
