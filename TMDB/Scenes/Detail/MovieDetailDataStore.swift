//
//  MovieDetailDataStore.swift
//  TMDB
//
//  Created by Matheus Cardoso Kuhn on 21/10/19.
//  Copyright © 2019 MDT. All rights reserved.
//

import Foundation

protocol MovieDetailDataStoring: AnyObject {
    var genres: [GenreResponse] { get set }
    var movieResponse: MovieResponse! { get set }
    var movie: MovieDetail.Movie! { get set }
}

final class MovieDetailDataStore: MovieDetailDataStoring {
    var genres: [GenreResponse] = []
    var movieResponse: MovieResponse!
    var movie: MovieDetail.Movie!
}
