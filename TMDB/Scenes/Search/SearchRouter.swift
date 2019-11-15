//
//  SearchRouter.swift
//  TMDB
//
//  Created by Matheus Cardoso Kuhn on 26/10/19.
//  Copyright © 2019 MDT. All rights reserved.
//

import Foundation

protocol SearchRouter {
    var searchDataStore: SearchDataStore? { get }
    var moviesDataStore: MoviesDataStore? { get }
    var moviesServiceDataStore: MoviesServiceDataStore? { get }
}

class SearchRouterImpl: SearchRouter {

    // MARK: - Variables
    private(set) weak var searchDataStore: SearchDataStore?
    private(set) weak var moviesDataStore: MoviesDataStore?
    private(set) weak var moviesServiceDataStore: MoviesServiceDataStore?

    // MARK: - Life Cycle
    init(searchDataStore: SearchDataStore,
         moviesDataStore: MoviesDataStore,
         moviesServiceDataStore: MoviesServiceDataStore) {
        self.searchDataStore = searchDataStore
        self.moviesDataStore = moviesDataStore
        self.moviesServiceDataStore = moviesServiceDataStore
    }
}

// MARK: - MovieDetailPassingData
extension SearchRouterImpl: MovieDetailPassingData {

    func passDetailData(destination: MovieDetailRouter, selectedIndex: Int) {
        guard
            let movie = moviesDataStore?.movies[selectedIndex],
            let genres = moviesDataStore?.genres
            else {
                return
        }
        destination.dataStore?.movieResponse = movie
        destination.dataStore?.genres = genres
    }
}
