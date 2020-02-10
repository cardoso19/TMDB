//
//  SearchInteractor.swift
//  TMDB
//
//  Created by Matheus Cardoso Kuhn on 20/10/19.
//  Copyright © 2019 MDT. All rights reserved.
//

import Foundation

protocol SearchInteracting {
    func doMoviesSearch(query: String)
    func searchTextChange(query: String)
}

final class SearchInteractor: SearchInteracting {

    // MARK: - Variables
    private let moviesPresenter: MoviesPresenting
    private let gateway: SearchGatewayLogic
    private let searchDataStore: SearchDataStoring
    private let moviesDataStore: MoviesDataStoring
    private let moviesServiceDataStore: MoviesServiceDataStoring
    private let moviesAdapter: MoviesAdapting

    // MARK: - Life Cycle
    init(moviesPresenter: MoviesPresenting,
         gateway: SearchGatewayLogic,
         searchDataStore: SearchDataStoring,
         moviesDataStore: MoviesDataStoring,
         moviesServiceDataStore: MoviesServiceDataStoring,
         moviesAdapter: MoviesAdapting) {
        self.moviesPresenter = moviesPresenter
        self.gateway = gateway
        self.searchDataStore = searchDataStore
        self.moviesDataStore = moviesDataStore
        self.moviesServiceDataStore = moviesServiceDataStore
        self.moviesAdapter = moviesAdapter
    }

    // MARK: - Genre
    private func getMovieGenreBy(genreID: Int) -> String? {
        for genre in moviesDataStore.genres where (genre.id ?? -1) == genreID {
            return genre.name
        }
        return nil
    }

    // MARK: - Movies
    func doMoviesSearch(query: String) {
        if query.isEmpty {
            moviesPresenter.presentMovies([])
        } else {
            guard
                !moviesServiceDataStore.isFetchingMovies,
                query != searchDataStore.previousSearchedQuery,
                // swiftlint:disable:next line_length
                (moviesServiceDataStore.totalPages == 0 || moviesServiceDataStore.currentPage <= moviesServiceDataStore.totalPages)
                else {
                    return
            }
            moviesServiceDataStore.isFetchingMovies = true
            searchDataStore.previousSearchedQuery = query
            gateway.searchMovies(query: query, page: moviesServiceDataStore.currentPage + 1) { [weak self] result in
                guard let self = self else { return }
                self.moviesServiceDataStore.isFetchingMovies = false
                switch result {
                case .success(let response):
                    self.moviesSearchSuccess(response: response)
                case .failure(let error):
                    self.moviesSearchFailure(error: error)
                }
            }
        }
    }

    private func moviesSearchSuccess(response: MoviesResponse) {
        guard let newMovies = response.results else { return }
        moviesDataStore.movies.append(contentsOf: newMovies)
        moviesServiceDataStore.totalPages = response.totalPages ?? -1
        moviesServiceDataStore.currentPage += 1
        let transformedMovies = newMovies.map { movie -> Movies.Movie in
            let genre = self.getMovieGenreBy(genreID: movie.genreIDs?.first ?? -1) ?? "-"
            return moviesAdapter.transform(movie: movie, genre: genre)
        }
        moviesPresenter.presentMovies(transformedMovies)
    }

    private func moviesSearchFailure(error: RequestError) {
        moviesPresenter.presentError(error)
    }

    // MARK: - Search
    func searchTextChange(query: String) {
        searchDataStore.timer?.invalidate()
        // TODO: - Suspend search request
        searchDataStore.timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { [weak self] _ in
            guard let self = self else { return }
            self.moviesServiceDataStore.currentPage = 0
            self.moviesServiceDataStore.totalPages = 0
            self.doMoviesSearch(query: query)
        })
    }
}
