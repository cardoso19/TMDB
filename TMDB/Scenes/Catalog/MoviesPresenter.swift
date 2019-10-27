//
//  MoviesPresenter.swift
//  TMDB
//
//  Created by Matheus Cardoso Kuhn on 11/10/19.
//  Copyright © 2019 MDT. All rights reserved.
//

import UIKit

protocol MoviesPresenter {
    func presentGenreError(error: RequestError)
    func presentMovies(movies: [Catalog.Movie])
    func presentMoviesError(error: RequestError)
}

class MoviesPresenterImpl: MoviesPresenter {

    // MARK: - Variables
    weak var viewController: MoviesViewControllerDisplayLogic?

    // MARK: - Genres
    func presentGenreError(error: RequestError) {
        viewController?.displayGenresError(message: error.localizedDescription)
    }

    // MARK: - Movies
    func presentMovies(movies: [Catalog.Movie]) {
        let viewModel: [MovieViewModel] = movies.map { movie -> MovieViewModel in
            return transformToViewModel(movie: movie)
        }
        viewController?.displayMovies(movies: viewModel)
    }

    private func transformToViewModel(movie: Catalog.Movie) -> MovieViewModel {
        let title = movie.title
        let genre = movie.genre
        let releaseDate = movie.releaseDate?.convertToString(format: "dd/MM/yyyy") ?? "-"
        let posterPath = movie.posterPath
        return MovieViewModel(title: title,
                              genre: genre,
                              releaseDate: releaseDate,
                              posterPath: posterPath)
    }

    func presentMoviesError(error: RequestError) {
        viewController?.displayMoviesError(message: error.localizedDescription)
    }
}
