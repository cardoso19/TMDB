//
//  MovieCollectionViewCell.swift
//  TMDB
//
//  Created by Matheus Cardoso kuhn on 26/08/2018.
//  Copyright © 2018 MDT. All rights reserved.
//

import UIKit

protocol MoviesCollectionViewCellDisplay: AnyObject {
    func display(image: UIImage)
    func display(imageError: RequestError)
}

class MovieCollectionViewCell: UICollectionViewCell {

    // MARK: - IBOutlets
    @IBOutlet private weak var imageViewPoster: UIImageView!
    @IBOutlet private weak var labelTitle: UILabel!
    @IBOutlet private weak var labelGenre: UILabel!
    @IBOutlet private weak var labelReleaseDate: UILabel!

    // MARK: - Variables
    private var interactor: MoviesCollectionViewCellInteractor!

    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }

    override func prepareForReuse() {
        self.imageViewPoster.image = #imageLiteral(resourceName: "defaultPosterImage")
    }

    private func setup() {
        let presenter = MoviesCollectionViewCellPresenterImpl()
        let gateway = MoviesCollectionViewCellGatewayImpl(httpRequest: HttpRequest())
        interactor = MoviesCollectionViewCellInteractorImpl(presenter: presenter,
                                                            gateway: gateway)
        presenter.cell = self
    }

    // MARK: - Content
    func setContent(viewModel: MovieViewModel) {
        labelTitle.text = viewModel.title
        labelGenre.text = viewModel.genre
        labelReleaseDate.text = viewModel.releaseDate
        interactor.downloadImage(posterUrl: viewModel.posterPath)
    }
}

// MARK: - MoviesCollectionViewCellDisplay
extension MovieCollectionViewCell: MoviesCollectionViewCellDisplay {

    func display(image: UIImage) {
        DispatchQueue.main.async { [weak self] in
            self?.imageViewPoster.image = image
        }
    }

    func display(imageError: RequestError) {
        // TODO: - Configurate image download error.
    }
}
