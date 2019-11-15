//
//  MoviesCollectionViewCellInteractor.swift
//  TMDB
//
//  Created by Matheus Cardoso Kuhn on 20/10/19.
//  Copyright © 2019 MDT. All rights reserved.
//

import UIKit

protocol MoviesCollectionViewCellInteractor {
    func downloadImage(posterUrl: String)
}

class MoviesCollectionViewCellInteractorImpl: MoviesCollectionViewCellInteractor {

    // MARK: - Variables
    private let presenter: MoviesCollectionViewCellPresenter
    private let imageGateway: ImageGateway

    // MARK: - Life Cycle
    init(presenter: MoviesCollectionViewCellPresenter, imageGateway: ImageGateway) {
        self.presenter = presenter
        self.imageGateway = imageGateway
    }

    // MARK: - Image
    func downloadImage(posterUrl: String) {
        imageGateway.downloadImage(posterUrl: posterUrl) { [weak self] result in
            switch result {
            case .success(let image):
                self?.downloadImageSuccess(image: image)
            case .failure(let error):
                self?.downloadImageFailure(error: error)
            }
        }
    }

    private func downloadImageSuccess(image: UIImage) {
        presenter.present(image: image)
    }

    private func downloadImageFailure(error: RequestError) {
        presenter.present(error: error)
    }
}
