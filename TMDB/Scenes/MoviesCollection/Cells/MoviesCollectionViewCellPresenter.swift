//
//  MoviesCollectionViewCellPresenter.swift
//  TMDB
//
//  Created by Matheus Cardoso Kuhn on 20/10/19.
//  Copyright © 2019 MDT. All rights reserved.
//

import UIKit

protocol MoviesCollectionViewCellPresenter {
    func present(image: UIImage)
    func present(error: RequestError)
}

class MoviesCollectionViewCellPresenterImpl: MoviesCollectionViewCellPresenter {

    // MARK: - Variables
    weak var cell: MoviesCollectionViewCellDisplay?

    // MARK: - Image
    func present(image: UIImage) {
        cell?.display(image: image)
    }

    func present(error: RequestError) {
        cell?.display(imageError: error)
    }
}
