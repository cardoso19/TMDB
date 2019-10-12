//
//  MovieCollectionViewCell.swift
//  TMDB
//
//  Created by Matheus Cardoso kuhn on 26/08/2018.
//  Copyright © 2018 MDT. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class MovieCollectionViewCell: UICollectionViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak var imageViewPoster: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelGenre: UILabel!
    @IBOutlet weak var labelReleaseDate: UILabel!

    // MARK: - Variables
//    var imageRequest: Alamofire.Request?
//    var downloadedImage: UIImage?

    // MARK: - Content
    func setContent(viewModel: MovieViewModel) {
        labelTitle.text = viewModel.title
        labelGenre.text = viewModel.genre
        labelReleaseDate.text = viewModel.releaseDate
//        imageRequest?.suspend()
        imageViewPoster.image = #imageLiteral(resourceName: "defaultPosterImage")
//        downloadedImage = nil
//        if let posterPath = item.posterPath {
//            imageRequest = Request.shared.IMAGE(path: posterPath) { (image) in
//                self.imageRequest = nil
//                if let image = image {
//                    self.downloadedImage = image
//                    self.imageViewPoster.image = image
//                }
//            }
//        }
    }
}
