//
//  MoviesRouter.swift
//  TMDB
//
//  Created by Matheus Cardoso Kuhn on 11/10/19.
//  Copyright © 2019 MDT. All rights reserved.
//

import Foundation

protocol MoviesRouter {

}

class MoviesRouterImpl: MoviesRouter {

    // MARK: - Variables
    weak var dataStore: MoviesDataStore?
}
