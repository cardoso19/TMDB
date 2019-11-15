//
//  MovieDetailPresenter.swift
//  TMDB
//
//  Created by Matheus Cardoso Kuhn on 21/10/19.
//  Copyright © 2019 MDT. All rights reserved.
//

import UIKit

protocol MovieDetailPresenter {
    func presentMovie(content: MovieDetail.Movie)
    func presentMovie(poster: UIImage)
    func present(error: RequestError)
}

class MovieDetailPresenterImpl: MovieDetailPresenter {

    // MARK: - Variables
    weak var viewController: MovieDetailViewControllerDisplayLogic?

    // MARK: - Content
    func presentMovie(content: MovieDetail.Movie) {
        let title = content.title
        let genre = content.genre
        let releaseDate = content.releaseDate?.convertToString(format: "dd/MM/yyyy") ?? "-"
        let overview = content.overview
        let viewModel = MovieDetail.MovieViewModel(title: title,
                                                   genre: genre,
                                                   releaseDate: releaseDate,
                                                   overview: overview)
        viewController?.displayMovie(content: viewModel)
    }

    // MARK: - Image
    func presentMovie(poster: UIImage) {
        viewController?.displayPoster(image: poster)
    }

    func present(error: RequestError) {
        viewController?.displayError(message: error.localizedDescription)
    }
}
