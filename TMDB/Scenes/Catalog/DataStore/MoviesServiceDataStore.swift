//
//  MoviesServiceDataStore.swift
//  TMDB
//
//  Created by Matheus Cardoso Kuhn on 14/11/19.
//  Copyright © 2019 MDT. All rights reserved.
//

import Foundation

protocol MoviesServiceDataStore: AnyObject {
    var currentPage: Int { get set }
    var totalPages: Int { get set }
    var isFetchingMovies: Bool { get set }
}

class MoviesServiceDataStoreImpl: MoviesServiceDataStore {
    var currentPage: Int = 0
    var totalPages: Int = 0
    var isFetchingMovies: Bool = false
}
