//
//  SearchRouter.swift
//  TMDB
//
//  Created by Matheus Cardoso Kuhn on 26/10/19.
//  Copyright © 2019 MDT. All rights reserved.
//

import Foundation

protocol SearchRouting {
    var searchDataStore: SearchDataStoring? { get }
    var moviesDataStore: MoviesDataStoring? { get }
    var moviesServiceDataStore: MoviesServiceDataStoring? { get }
}

final class SearchRouter: SearchRouting {

    // MARK: - Variables
    private(set) weak var searchDataStore: SearchDataStoring?
    private(set) weak var moviesDataStore: MoviesDataStoring?
    private(set) weak var moviesServiceDataStore: MoviesServiceDataStoring?

    // MARK: - Life Cycle
    init(searchDataStore: SearchDataStoring,
         moviesDataStore: MoviesDataStoring,
         moviesServiceDataStore: MoviesServiceDataStoring) {
        self.searchDataStore = searchDataStore
        self.moviesDataStore = moviesDataStore
        self.moviesServiceDataStore = moviesServiceDataStore
    }
}

// MARK: - MovieDetailPassingData
extension SearchRouter: MovieDetailDataPassing {

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
