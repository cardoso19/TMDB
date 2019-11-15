//
//  MovieDetailInteractor.swift
//  TMDB
//
//  Created by Matheus Cardoso Kuhn on 21/10/19.
//  Copyright © 2019 MDT. All rights reserved.
//

import UIKit

protocol MovieDetailInteractor {
    func showMovieContent()
}

class MovieDetailInteractorImpl: MovieDetailInteractor {

    // MARK: - Variables
    private let presenter: MovieDetailPresenter
    private let imageGateway: ImageGateway
    private let dataStore: MovieDetailDataStore
    private let adapter: MovieDetailAdapter

    // MARK: - Life Cycle
    init(presenter: MovieDetailPresenter,
         imageGateway: ImageGateway,
         dataStore: MovieDetailDataStore,
         adapter: MovieDetailAdapter) {
        self.presenter = presenter
        self.imageGateway = imageGateway
        self.dataStore = dataStore
        self.adapter = adapter
    }

    // MARK: - Movie
    func showMovieContent() {
        guard let responseMovie = dataStore.movieResponse else { return }
        dataStore.movie = adapter.transform(movie: responseMovie,
                                            genre: getMovieGenreBy(genreID: responseMovie.genreIDs?.first ?? -1) ?? "-")
        presenter.presentMovie(content: dataStore.movie)
        guard !dataStore.movie.posterPath.isEmpty
            else {
                return
        }
        imageGateway.downloadImage(posterUrl: dataStore.movie.posterPath) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let image):
                self.imageDownloadSuccess(image: image)
            case .failure(let error):
                self.imageDownloadError(error: error)
            }
        }
    }

    private func imageDownloadSuccess(image: UIImage) {
        presenter.presentMovie(poster: image)
    }

    private func imageDownloadError(error: RequestError) {
        presenter.present(error: error)
    }

    // MARK: - Genres
    private func getMovieGenreBy(genreID: Int) -> String? {
        for genre in dataStore.genres where (genre.id ?? -1) == genreID {
            return genre.name
        }
        return nil
    }
}
