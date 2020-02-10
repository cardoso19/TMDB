//
//  MovieDetailAdapter.swift
//  TMDB
//
//  Created by Matheus Cardoso Kuhn on 26/10/19.
//  Copyright © 2019 MDT. All rights reserved.
//

import Foundation

protocol MovieDetailAdapting {
    func transform(movie: MovieResponse, genre: String) -> MovieDetail.Movie
}

final class MovieDetailAdapter: MovieDetailAdapting {

    func transform(movie: MovieResponse, genre: String) -> MovieDetail.Movie {
        return MovieDetail.Movie(title: movie.title ?? "",
                                 genre: genre,
                                 releaseDate: movie.releaseDate?.value,
                                 posterPath: movie.posterPath ?? "",
                                 overview: movie.overview ?? "")
    }
}
