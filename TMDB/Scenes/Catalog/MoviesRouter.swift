//
//  MoviesRouter.swift
//  TMDB
//
//  Created by Matheus Cardoso Kuhn on 11/10/19.
//  Copyright © 2019 MDT. All rights reserved.
//

import Foundation

protocol MoviesRouting {
    var moviesDataStore: MoviesDataStoring? { get }
    var moviesServiceDataStore: MoviesServiceDataStoring? { get }
}

final class MoviesRouter: MoviesRouting {

    // MARK: - Variables
    private(set) weak var moviesDataStore: MoviesDataStoring?
    private(set) weak var moviesServiceDataStore: MoviesServiceDataStoring?

    // MARK: - Life Cycle
    init(moviesDataStore: MoviesDataStoring, moviesServiceDataStore: MoviesServiceDataStoring) {
        self.moviesDataStore = moviesDataStore
        self.moviesServiceDataStore = moviesServiceDataStore
    }
}

// MARK: - MovieDetailPassingData
extension MoviesRouter: MovieDetailDataPassing {

    func passDetailData(destination: MovieDetailRouting, selectedIndex: Int) {
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
