//
//  MoviesRouter.swift
//  TMDB
//
//  Created by Matheus Cardoso Kuhn on 11/10/19.
//  Copyright © 2019 MDT. All rights reserved.
//

import Foundation

protocol MoviesRouter {
    var moviesDataStore: MoviesDataStore? { get }
    var moviesServiceDataStore: MoviesServiceDataStore? { get }
}

class MoviesRouterImpl: MoviesRouter {

    // MARK: - Variables
    private(set) weak var moviesDataStore: MoviesDataStore?
    private(set) weak var moviesServiceDataStore: MoviesServiceDataStore?

    // MARK: - Life Cycle
    init(moviesDataStore: MoviesDataStore, moviesServiceDataStore: MoviesServiceDataStore) {
        self.moviesDataStore = moviesDataStore
        self.moviesServiceDataStore = moviesServiceDataStore
    }
}

// MARK: - MovieDetailPassingData
extension MoviesRouterImpl: MovieDetailPassingData {

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
