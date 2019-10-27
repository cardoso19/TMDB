//
//  SearchRouter.swift
//  TMDB
//
//  Created by Matheus Cardoso Kuhn on 26/10/19.
//  Copyright © 2019 MDT. All rights reserved.
//

import Foundation

protocol SearchRouter {
    var dataStore: SearchDataStore? { get }
}

class SearchRouterImpl: SearchRouter {

    // MARK: - Variables
    weak var dataStore: SearchDataStore?

    // MARK: - Life Cycle
    init(dataStore: SearchDataStore) {
        self.dataStore = dataStore
    }
}
