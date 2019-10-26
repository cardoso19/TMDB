//
//  MoviesRouter.swift
//  TMDB
//
//  Created by Matheus Cardoso Kuhn on 11/10/19.
//  Copyright © 2019 MDT. All rights reserved.
//

import Foundation

protocol MoviesRouter {
    var dataStore: MoviesDataStore? { get }
}

class MoviesRouterImpl: MoviesRouter {

    // MARK: - Variables
    weak var dataStore: MoviesDataStore?

    // MARK: - Life Cycle
    init(dataStore: MoviesDataStore) {
        self.dataStore = dataStore
    }
}
