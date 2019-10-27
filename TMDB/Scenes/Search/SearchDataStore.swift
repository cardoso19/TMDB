//
//  SearchDataStore.swift
//  TMDB
//
//  Created by Matheus Cardoso Kuhn on 20/10/19.
//  Copyright © 2019 MDT. All rights reserved.
//

import Foundation

protocol SearchDataStore: AnyObject {
    var genres: [GenreResponse] { get set }
    var movies: [MovieResponse] { get set }
    var currentPage: Int { get set }
    var totalPages: Int { get set }
    var isSearchingMovies: Bool { get set }
    var previousSearchedQuery: String? { get set }
    var timer: Timer? { get set }
}

class SearchDataStoreImpl: SearchDataStore {
    var genres: [GenreResponse] = []
    var movies: [MovieResponse] = []
    var currentPage: Int = 0
    var totalPages: Int = 0
    var isSearchingMovies: Bool = false
    var previousSearchedQuery: String?
    var timer: Timer?
}
