//
//  MovieDetailRouter.swift
//  TMDB
//
//  Created by Matheus Cardoso Kuhn on 26/10/19.
//  Copyright © 2019 MDT. All rights reserved.
//

import Foundation

protocol MovieDetailRouter {
    var dataStore: MovieDetailDataStore? { get }
}

class MovieDetailRouterImpl: MovieDetailRouter {

    // MARK: - Variables
    weak var dataStore: MovieDetailDataStore?

    // MARK: - Life Cycle
    init(dataStore: MovieDetailDataStore) {
        self.dataStore = dataStore
    }
}
