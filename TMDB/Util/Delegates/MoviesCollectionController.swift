//
//  MoviesCollectionController.swift
//  TMDB
//
//  Created by Matheus Cardoso kuhn on 28/08/2018.
//  Copyright © 2018 MDT. All rights reserved.
//

import Foundation

protocol MoviesCollectionController {
    func updateMovies(_ movies: [Movie])
    func reloadData()
}
