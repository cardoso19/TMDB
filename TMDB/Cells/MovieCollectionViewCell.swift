//
//  MovieCollectionViewCell.swift
//  TMDB
//
//  Created by Matheus Cardoso kuhn on 26/08/2018.
//  Copyright © 2018 MDT. All rights reserved.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {

    // MARK: - IBOutlets
    @IBOutlet private weak var imageViewPoster: UIImageView!
    @IBOutlet private weak var labelTitle: UILabel!
    @IBOutlet private weak var labelGenre: UILabel!
    @IBOutlet private weak var labelReleaseDate: UILabel!

    // MARK: - Content
    func setContent(viewModel: MovieViewModel) {
        labelTitle.text = viewModel.title
        labelGenre.text = viewModel.genre
        labelReleaseDate.text = viewModel.releaseDate
    }

    func setDefaultImage() {
        imageViewPoster.image = #imageLiteral(resourceName: "defaultPosterImage")
    }

    func set(image: UIImage) {
        imageViewPoster.image = image
    }

    override func prepareForReuse() {
        self.imageViewPoster.image = nil
    }
}
