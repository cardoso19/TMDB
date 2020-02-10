//
//  MovieDetailRouter.swift
//  TMDB
//
//  Created by Matheus Cardoso Kuhn on 26/10/19.
//  Copyright © 2019 MDT. All rights reserved.
//

import Foundation

protocol MovieDetailRouting {
    var dataStore: MovieDetailDataStoring? { get }
}

protocol MovieDetailDataPassing {
    func passDetailData(destination: MovieDetailRouting, selectedIndex: Int)
}

final class MovieDetailRouter: MovieDetailRouting {

    // MARK: - Variables
    weak var dataStore: MovieDetailDataStoring?

    // MARK: - Life Cycle
    init(dataStore: MovieDetailDataStoring) {
        self.dataStore = dataStore
    }
}
