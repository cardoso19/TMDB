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
}

class BaseTabBarRouterImpl: BaseTabBarRouter {

    func passGenreData(sourceRouter: MoviesRouter, destination: SearchRouter) {
        destination.moviesDataStore?.genres = sourceRouter.moviesDataStore?.genres ?? []
    }
}
