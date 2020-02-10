//
//  MoviesAdapter.swift
//  TMDB
//
//  Created by Matheus Cardoso Kuhn on 12/10/19.
//  Copyright © 2019 MDT. All rights reserved.
//

import Foundation

protocol MoviesAdapting {
    func transform(movie: MovieResponse, genre: String) -> Movies.Movie
}

final class MoviesAdapter: MoviesAdapting {

    func transform(movie: MovieResponse, genre: String) -> Movies.Movie {
        return Movies.Movie(title: movie.title ?? "",
                            genre: genre,
                            releaseDate: movie.releaseDate?.value,
                            posterPath: movie.posterPath ?? "")
    }

}
