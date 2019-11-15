//
//  GenrePresenter.swift
//  TMDB
//
//  Created by Matheus Cardoso Kuhn on 14/11/19.
//  Copyright © 2019 MDT. All rights reserved.
//

import Foundation

protocol GenrePresenter {
    func presentGenreError(error: RequestError)
}

class GenrePresenterImpl: GenrePresenter {

    // MARK: - Variables
    weak var viewController: GenreDisplayLogic?

    // MARK: - Genres
    func presentGenreError(error: RequestError) {
        viewController?.displayError(message: error.localizedDescription)
    }
}
