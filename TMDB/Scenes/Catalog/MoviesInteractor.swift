//
//  MoviesInteractor.swift
//  TMDB
//
//  Created by Matheus Cardoso Kuhn on 11/10/19.
//  Copyright © 2019 MDT. All rights reserved.
//

import Foundation

protocol MoviesInteractorLogic {
    
}

class MoviesInteractor: MoviesInteractorLogic {
    
    // MARK: - Variables
    private let presenter: MoviesPresenterLogic
    private let worker: MoviesWorkerLogic
    
    // MARK: - Life Cycle
    init(presenter: MoviesPresenterLogic, worker: MoviesWorkerLogic) {
        self.presenter = presenter
        self.worker = worker
    }
}
