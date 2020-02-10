//
//  MoviesPresenter.swift
//  TMDB
//
//  Created by Matheus Cardoso Kuhn on 11/10/19.
//  Copyright © 2019 MDT. All rights reserved.
//

import UIKit

protocol MoviesPresenting {
    func presentMovies(_ movies: [Movies.Movie])
    func presentError(_ error: RequestError)
}

final class MoviesPresenter: MoviesPresenting {

    // MARK: - Variables
    weak var viewController: MoviesDisplayLogic?

    // MARK: - Movies
    private func transformToViewModel(movie: Movies.Movie) -> Movies.MovieViewModel {
        let title = movie.title
        let genre = movie.genre
        let releaseDate = movie.releaseDate?.convertToString(format: "dd/MM/yyyy") ?? "-"
        let posterPath = movie.posterPath
        return Movies.MovieViewModel(title: title,
                                     genre: genre,
                                     releaseDate: releaseDate,
                                     posterPath: posterPath)
    }

    func presentMovies(_ movies: [Movies.Movie]) {
        let viewModel: [Movies.MovieViewModel] = movies.map { movie -> Movies.MovieViewModel in
            return transformToViewModel(movie: movie)
        }
        viewController?.displayMovies(viewModel)
    }

    func presentError(_ error: RequestError) {
        viewController?.displayError(message: error.localizedDescription)
    }
}
