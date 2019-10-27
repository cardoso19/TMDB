//
//  BaseTabBarRouter.swift
//  TMDB
//
//  Created by Matheus Cardoso Kuhn on 26/10/19.
//  Copyright © 2019 MDT. All rights reserved.
//

import Foundation

protocol BaseTabBarRouter {
    func passGenreData(sourceRouter: MoviesRouter, destination: SearchRouter)
    func passDetailData(sourceRouter: MoviesRouter, destination: MovieDetailRouter, selectedIndex: Int)
    func passDetailData(sourceRouter: SearchRouter, destination: MovieDetailRouter, selectedIndex: Int)
}

class BaseTabBarRouterImpl: BaseTabBarRouter {

    func passGenreData(sourceRouter: MoviesRouter, destination: SearchRouter) {
        destination.dataStore?.genres = sourceRouter.dataStore?.genres ?? []
    }

    func passDetailData(sourceRouter: MoviesRouter, destination: MovieDetailRouter, selectedIndex: Int) {
        guard
            let movie = sourceRouter.dataStore?.movies[selectedIndex],
            let genres = sourceRouter.dataStore?.genres
            else {
                return
        }
        pass(movie: movie,
             destination: destination,
             genres: genres)
    }

    func passDetailData(sourceRouter: SearchRouter, destination: MovieDetailRouter, selectedIndex: Int) {
        guard
            let movie = sourceRouter.dataStore?.movies[selectedIndex],
            let genres = sourceRouter.dataStore?.genres
            else {
                return
        }
        pass(movie: movie,
             destination: destination,
             genres: genres)
    }

    private func pass(movie: MovieResponse, destination: MovieDetailRouter, genres: [GenreResponse]) {
        destination.dataStore?.movieResponse = movie
        destination.dataStore?.genres = genres
    }
}
