//
//  GenrePresenter.swift
//  TMDB
//
//  Created by Matheus Cardoso Kuhn on 14/11/19.
//  Copyright © 2019 MDT. All rights reserved.
//

import Foundation

protocol GenrePresenting {
    func presentGenreError(error: RequestError)
}

final class GenrePresenter: GenrePresenting {

    // MARK: - Variables
    weak var viewController: GenreDisplayLogic?

    // MARK: - Genres
    func presentGenreError(error: RequestError) {
        viewController?.displayError(message: error.localizedDescription)
    }
}
