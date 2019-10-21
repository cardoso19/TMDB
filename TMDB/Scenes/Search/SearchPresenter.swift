//
//  SearchPresenter.swift
//  TMDB
//
//  Created by Matheus Cardoso Kuhn on 20/10/19.
//  Copyright © 2019 MDT. All rights reserved.
//

import Foundation

protocol SearchPresenter {
    func present(movies: [Search.Movie])
    func present(error: RequestError)
}

class SearchPresenterImpl: SearchPresenter {
    
    // MARK: - Variables
    weak var viewController: SearchViewControllerDisplayLogic?

    // MARK: - Movies
    func present(movies: [Search.Movie]) {
        let viewModel = movies.map { movie -> MovieViewModel in
            return transformToViewModel(movie: movie)
        }
        viewController?.display(movies: viewModel)
    }

    private func transformToViewModel(movie: Search.Movie) -> MovieViewModel {
        let title = movie.title
        let genre = movie.genre
        let releaseDate = movie.releaseDate?.convertToString(format: "dd/MM/yyyy") ?? "-"
        let posterPath = movie.posterPath
        return MovieViewModel(title: title,
                              genre: genre,
                              releaseDate: releaseDate,
                              posterPath: posterPath)
    }

    func present(error: RequestError) {
        viewController?.display(message: error.localizedDescription)
    }
}
