//
//  MoviesRouter.swift
//  TMDB
//
//  Created by Matheus Cardoso Kuhn on 11/10/19.
//  Copyright © 2019 MDT. All rights reserved.
//

import Foundation

protocol MoviesRouterLogic {
    
}

class MoviesRouter: MoviesRouterLogic {
    
    // MARK: - Variables
    weak var dataStore: MoviesDataStoreLogic?
}
