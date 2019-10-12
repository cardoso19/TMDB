//
//  MoviesInteractor.swift
//  TMDB
//
//  Created by Matheus Cardoso Kuhn on 11/10/19.
//  Copyright © 2019 MDT. All rights reserved.
//

import Foundation

protocol MoviesInteractorLogic {
    func fetchGenres()
    func fetchMovies()
}

class MoviesInteractor: MoviesInteractorLogic {

    // MARK: - Variables
    private let presenter: MoviesPresenterLogic
    private let worker: MoviesWorkerLogic
    private let dataStore: MoviesDataStoreLogic

    // MARK: - Life Cycle
    init(presenter: MoviesPresenterLogic, worker: MoviesWorkerLogic, dataStore: MoviesDataStoreLogic) {
        self.presenter = presenter
        self.worker = worker
        self.dataStore = dataStore
    }

    // MARK: - Genres
    func fetchGenres() {
        worker.fetchGenres { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let genres):
                self.dataStore.genres = genres
            case .failure(let error):
                self.presenter.presentGenreError(error: error)
            }
        }
    }

    private func getMovieGenreBy(genreID: Int) -> String? {
        for genre in dataStore.genres where (genre.identifier ?? -1) == genreID {
            return genre.name
        }
        return nil
    }

    // MARK: - Movies
    func fetchMovies() {
        if !dataStore.isRequesting && (dataStore.totalPages == 0 || dataStore.currentPage <= dataStore.totalPages) {
            if dataStore.currentPage == 0 {
                MDTLoading.showDefaultLoader()
            }
            dataStore.isRequesting = true
            worker.fetchMovies(page: dataStore.currentPage + 1) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let moviesResponse):
                    guard let newMovies = moviesResponse.results else { return }
                    self.dataStore.totalPages = moviesResponse.totalPages ?? -1
                    self.dataStore.currentPage += 1
                    self.dataStore.movies.append(contentsOf: newMovies)
                    self.presenter.presentMovies(movies: newMovies)
                case .failure(let error):
                    self.presenter.presentMoviesError(error: error)
                }
                self.dataStore.isRequesting = false
            }
        }
    }
}
