//
//  SearchAdapter.swift
//  TMDB
//
//  Created by Matheus Cardoso Kuhn on 20/10/19.
//  Copyright © 2019 MDT. All rights reserved.
//

import Foundation

protocol SearchAdapter {
    func transform(movie: MovieResponse, genre: String) -> Search.Movie
}

class SearchAdapterImpl: SearchAdapter {

    func transform(movie: MovieResponse, genre: String) -> Search.Movie {
        return Search.Movie(title: movie.title ?? "",
                            genre: genre,
                            releaseDate: movie.releaseDate?.value,
                            posterPath: movie.posterPath ?? "")
    }
}
