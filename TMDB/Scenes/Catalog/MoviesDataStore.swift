//
//  MoviesDataStore.swift
//  TMDB
//
//  Created by Matheus Cardoso Kuhn on 11/10/19.
//  Copyright © 2019 MDT. All rights reserved.
//

import Foundation

protocol MoviesDataStoreLogic: AnyObject {
    var genres: [Genre] { get set }
    var movies: [Movie] { get set }
    var currentPage: Int { get set }
    var totalPages: Int { get set }
    var isRequesting: Bool { get set }
}

class MoviesDataStore: MoviesDataStoreLogic {
    var genres: [Genre] = []
    var movies: [Movie] = []
    var currentPage: Int = 0
    var totalPages: Int = 0
    var isRequesting: Bool = false
}
