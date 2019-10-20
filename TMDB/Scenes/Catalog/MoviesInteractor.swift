//
//  MoviesInteractor.swift
//  TMDB
//
//  Created by Matheus Cardoso Kuhn on 11/10/19.
//  Copyright © 2019 MDT. All rights reserved.
//

import UIKit

protocol MoviesInteractorLogic {
    func fetchGenres()
    func fetchMovies()
    func downloadImage(posterUrl: String, indexPath: IndexPath)
}

class MoviesInteractor: MoviesInteractorLogic {

    // MARK: - Variables
    private let presenter: MoviesPresenterLogic
    private let gateway: MoviesGatewayLogic
    private let dataStore: MoviesDataStoreLogic
    private let adapter: MoviesAdapterLogic

    // MARK: - Life Cycle
    init(presenter: MoviesPresenterLogic,
         gateway: MoviesGatewayLogic,
         dataStore: MoviesDataStoreLogic,
         adapter: MoviesAdapterLogic) {
        self.presenter = presenter
        self.gateway = gateway
        self.dataStore = dataStore
        self.adapter = adapter
    }

    // MARK: - Genres
    func fetchGenres() {
        gateway.fetchGenres { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let genreResponse):
                self.genresSuccess(genres: genreResponse.genres)
            case .failure(let error):
                self.genresFailure(error: error)
            }
        }
    }

    private func genresSuccess(genres: [GenreResponse]) {
        dataStore.genres = genres
        fetchMovies()
    }

    private func genresFailure(error: RequestError) {
        presenter.presentGenreError(error: error)
    }

    private func getMovieGenreBy(genreID: Int) -> String? {
        for genre in dataStore.genres where (genre.id ?? -1) == genreID {
            return genre.name
        }
        return nil
    }

    // MARK: - Movies
    func fetchMovies() {
        if !dataStore.isFetchingMovies && (dataStore.totalPages == 0 || dataStore.currentPage <= dataStore.totalPages) {
            dataStore.isFetchingMovies = true
            gateway.fetchMovies(page: dataStore.currentPage + 1) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let moviesResponse):
                    self.moviesSuccess(moviesResponse: moviesResponse)
                case .failure(let error):
                    self.moviesFailure(error: error)
                }
                self.dataStore.isFetchingMovies = false
            }
        }
    }

    private func moviesSuccess(moviesResponse: MoviesResponse) {
        guard let newMovies = moviesResponse.results else { return }
        dataStore.totalPages = moviesResponse.totalPages ?? -1
        dataStore.currentPage += 1
        dataStore.movies.append(contentsOf: newMovies)
        let transformedMovies = newMovies.map({ movie -> Catalog.Movie in
            let genre = self.getMovieGenreBy(genreID: movie.genreIDs?.first ?? -1) ?? "-"
            return self.adapter.transform(movie: movie, genre: genre)
        })
        presenter.presentMovies(movies: transformedMovies)
    }

    private func moviesFailure(error: RequestError) {
        presenter.presentMoviesError(error: error)
    }

    // MARK: - Image
    func downloadImage(posterUrl: String, indexPath: IndexPath) {
        gateway.downloadImage(posterUrl: posterUrl) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let image):
                self.imageSuccess(image: image, indexPath: indexPath)
            case .failure(let error):
                self.imageFailure(error: error)
            }
        }
    }

    private func imageSuccess(image: UIImage, indexPath: IndexPath) {
        presenter.presentImage(image: image, indexPath: indexPath)
    }

    private func imageFailure(error: RequestError) {
        presenter.presentImageError(error: error)
    }
}
