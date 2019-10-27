//
//  SearchInteractor.swift
//  TMDB
//
//  Created by Matheus Cardoso Kuhn on 20/10/19.
//  Copyright © 2019 MDT. All rights reserved.
//

import Foundation

protocol SearchInteractor {
    func doMoviesSearch(query: String)
    func searchTextChange(query: String)
}

class SearchInteractorImpl: SearchInteractor {

    // MARK: - Variables
    private let presenter: SearchPresenter
    private let gateway: SearchGateway
    private let dataStore: SearchDataStore
    private let adapter: SearchAdapter

    // MARK: - Life Cycle
    init(presenter: SearchPresenter, gateway: SearchGateway, dataStore: SearchDataStore, adapter: SearchAdapter) {
        self.presenter = presenter
        self.gateway = gateway
        self.dataStore = dataStore
        self.adapter = adapter
    }

    // MARK: - Genre
    private func getMovieGenreBy(genreID: Int) -> String? {
        for genre in dataStore.genres where (genre.id ?? -1) == genreID {
            return genre.name
        }
        return nil
    }

    // MARK: - Movies
    func doMoviesSearch(query: String) {
        if query.isEmpty {
            presenter.present(movies: [])
        } else {
            guard
                !dataStore.isSearchingMovies,
                query != dataStore.previousSearchedQuery,
                (dataStore.totalPages == 0 || dataStore.currentPage <= dataStore.totalPages)
                else {
                    return
            }
            dataStore.isSearchingMovies = true
            dataStore.previousSearchedQuery = query
            gateway.searchMovies(query: query, page: dataStore.currentPage + 1) { [weak self] result in
                guard let self = self else { return }
                self.dataStore.isSearchingMovies = false
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
        dataStore.movies.append(contentsOf: newMovies)
        dataStore.totalPages = response.totalPages ?? -1
        dataStore.currentPage += 1
        let transformedMovies = newMovies.map { movie -> Search.Movie in
            let genre = self.getMovieGenreBy(genreID: movie.genreIDs?.first ?? -1) ?? "-"
            return adapter.transform(movie: movie, genre: genre)
        }
        presenter.present(movies: transformedMovies)
    }

    private func moviesSearchFailure(error: RequestError) {
        presenter.present(error: error)
    }

    // MARK: - Search
    func searchTextChange(query: String) {
        dataStore.timer?.invalidate()
        // TODO: - Suspend search request
        dataStore.timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { [weak self] _ in
            guard let self = self else { return }
            self.dataStore.currentPage = 0
            self.dataStore.totalPages = 0
            self.doMoviesSearch(query: query)
        })
    }
}
