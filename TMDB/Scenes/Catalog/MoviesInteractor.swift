//
//  MoviesInteractor.swift
//  TMDB
//
//  Created by Matheus Cardoso Kuhn on 11/10/19.
//  Copyright © 2019 MDT. All rights reserved.
//

import Foundation

protocol MoviesInteractorLogic {
    func fetchGenres()
    func moviesCatalog()
}

class MoviesInteractor: MoviesInteractorLogic {
    
    // MARK: - Variables
    private let presenter: MoviesPresenterLogic
    private let worker: MoviesWorkerLogic
    private let dataStore: MoviesDataStoreLogic
    
    // MARK: - Life Cycle
    init(presenter: MoviesPresenterLogic, worker: MoviesWorkerLogic, dataStore: MoviesDataStoreLogic) {
        self.presenter = presenter
        self.worker = worker
        self.dataStore = dataStore
    }
    
    // MARK: - Genres
    func fetchGenres() {
        
    }
    
    // MARK: - Catalog
    func moviesCatalog() {
        
    }
}
