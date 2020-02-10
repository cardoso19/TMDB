//
//  BaseTabBarRouter.swift
//  TMDB
//
//  Created by Matheus Cardoso Kuhn on 26/10/19.
//  Copyright © 2019 MDT. All rights reserved.
//

import Foundation

protocol BaseTabBarRouting {
    func passGenreData(sourceRouter: MoviesRouting, destination: SearchRouting)
}

final class BaseTabBarRouter: BaseTabBarRouting {

    func passGenreData(sourceRouter: MoviesRouting, destination: SearchRouting) {
        destination.moviesDataStore?.genres = sourceRouter.moviesDataStore?.genres ?? []
    }
}
