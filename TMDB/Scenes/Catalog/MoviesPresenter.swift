//
//  MoviesPresenter.swift
//  TMDB
//
//  Created by Matheus Cardoso Kuhn on 11/10/19.
//  Copyright © 2019 MDT. All rights reserved.
//

import Foundation

protocol MoviesPresenterLogic {
    func presentGenreError(error: NSError)
    func presentMovies(movies: [Movie])
    func presentMoviesError(error: NSError)
}

class MoviesPresenter: MoviesPresenterLogic {

    // MARK: - Variables
    weak var viewController: MoviesViewControllerLogic?
    
    // MARK: - Genres
    func presentGenreError(error: NSError) {
        let message = (error.userInfo["message"] as? String) ?? "Error"
        viewController?.displayGenresError(message: message)
    }
    
    // MARK: - Movies
    func presentMovies(movies: [Movie]) {
        let viewModel: [MovieViewModel] = movies.map { movie -> MovieViewModel in
            return transformToViewModel(movie: movie)
        }
        viewController?.displayMovies(movies: viewModel)
    }
    
    private func transformToViewModel(movie: Movie) -> MovieViewModel {
        let title = movie.title ?? ""
        let genre = "-"
        let releaseDate = movie.releaseDate?.value?.convertToString(format: "dd/MM/yyyy") ?? ""
        return MovieViewModel(title: title,
                              genre: genre,
                              releaseDate: releaseDate)
    }
    
    func presentMoviesError(error: NSError) {
        let message = (error.userInfo["message"] as? String) ?? "Error"
        viewController?.displayMoviesError(message: message)
    }
}
