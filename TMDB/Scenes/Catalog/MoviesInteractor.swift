//
//  MoviesInteractor.swift
//  TMDB
//
//  Created by Matheus Cardoso Kuhn on 11/10/19.
//  Copyright © 2019 MDT. All rights reserved.
//

import UIKit

protocol MoviesInteracting {
    func fetchGenres()
    func fetchMovies()
}

final class MoviesInteractor: MoviesInteracting {

    // MARK: - Variables
    private let moviesPresenter: MoviesPresenting
    private let genrePresenter: GenrePresenting
    private let gateway: MoviesGatewayLogic
    private let moviesDataStore: MoviesDataStoring
    private let serviceDataStore: MoviesServiceDataStoring
    private let adapter: MoviesAdapting

    // MARK: - Life Cycle
    init(moviesPresenter: MoviesPresenting,
         genrePresenter: GenrePresenting,
         gateway: MoviesGatewayLogic,
         moviesDataStore: MoviesDataStoring,
         serviceDataStore: MoviesServiceDataStoring,
         adapter: MoviesAdapting) {
        self.moviesPresenter = moviesPresenter
        self.genrePresenter = genrePresenter
        self.gateway = gateway
        self.moviesDataStore = moviesDataStore
        self.serviceDataStore = serviceDataStore
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
        moviesDataStore.genres = genres
        fetchMovies()
    }

    private func genresFailure(error: RequestError) {
        genrePresenter.presentGenreError(error: error)
    }

    private func getMovieGenreBy(genreID: Int) -> String? {
        for genre in moviesDataStore.genres where (genre.id ?? -1) == genreID {
            return genre.name
        }
        return nil
    }

    // MARK: - Movies
    func fetchMovies() {
        guard
            !serviceDataStore.isFetchingMovies,
            (serviceDataStore.totalPages == 0 || serviceDataStore.currentPage <= serviceDataStore.totalPages)
            else {
                return
        }
        serviceDataStore.isFetchingMovies = true
        gateway.fetchMovies(page: serviceDataStore.currentPage + 1) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let moviesResponse):
                self.moviesSuccess(moviesResponse: moviesResponse)
            case .failure(let error):
                self.moviesFailure(error: error)
            }
            self.serviceDataStore.isFetchingMovies = false
        }
    }

    private func moviesSuccess(moviesResponse: MoviesResponse) {
        guard let newMovies = moviesResponse.results else { return }
        serviceDataStore.totalPages = moviesResponse.totalPages ?? -1
        serviceDataStore.currentPage += 1
        moviesDataStore.movies.append(contentsOf: newMovies)
        let transformedMovies = newMovies.map({ movie -> Movies.Movie in
            let genre = self.getMovieGenreBy(genreID: movie.genreIDs?.first ?? -1) ?? "-"
            return self.adapter.transform(movie: movie, genre: genre)
        })
        moviesPresenter.presentMovies(transformedMovies)
    }

    private func moviesFailure(error: RequestError) {
        moviesPresenter.presentError(error)
    }
}
