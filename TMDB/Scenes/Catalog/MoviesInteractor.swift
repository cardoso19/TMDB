//
//  MoviesInteractor.swift
//  TMDB
//
//  Created by Matheus Cardoso Kuhn on 11/10/19.
//  Copyright © 2019 MDT. All rights reserved.
//

import UIKit

protocol MoviesInteractor {
    func fetchGenres()
    func fetchMovies()
}

class MoviesInteractorImpl: MoviesInteractor {

    // MARK: - Variables
    private let presenter: MoviesPresenter
    private let gateway: MoviesGatewayLogic
    private let dataStore: MoviesDataStore
    private let adapter: MoviesAdapter

    // MARK: - Life Cycle
    init(presenter: MoviesPresenter,
         gateway: MoviesGatewayLogic,
         dataStore: MoviesDataStore,
         adapter: MoviesAdapter) {
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
}
