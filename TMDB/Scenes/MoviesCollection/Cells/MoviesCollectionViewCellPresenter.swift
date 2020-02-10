//
//  MoviesCollectionViewCellPresenter.swift
//  TMDB
//
//  Created by Matheus Cardoso Kuhn on 20/10/19.
//  Copyright © 2019 MDT. All rights reserved.
//

import UIKit

protocol MoviesCollectionViewCellPresenting {
    func present(image: UIImage)
    func present(error: RequestError)
}

final class MoviesCollectionViewCellPresenter: MoviesCollectionViewCellPresenting {

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
