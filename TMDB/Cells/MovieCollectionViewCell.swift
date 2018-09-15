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
    //==--------------------------------==
    // MARK: - IBOutlets
    //==--------------------------------==
    @IBOutlet weak var imageViewPoster: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelGenre: UILabel!
    @IBOutlet weak var labelReleaseDate: UILabel!
    //==--------------------------------==
    // MARK: - Variables
    //==--------------------------------==
    var imageRequest: Alamofire.Request?
    var downloadedImage: UIImage?
    //==--------------------------------==
    // MARK: - Init
    //==--------------------------------==
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    //==--------------------------------==
    // MARK: - Interactions
    //==--------------------------------==
    func setContent(item: Movie) {
        labelTitle.text = item.title ?? "-"
        if let date = item.releaseDate?.toDate(format: "yyyy/MM/dd") {
            labelReleaseDate.text = date.dateString(ofStyle: .short)
        } else {
            labelReleaseDate.text = "-/-/-"
        }
        if let genreID = item.genreIDs?.first, let genreName = MDTGenres.shared.getMovieGenreBy(genreID: genreID) {
            labelGenre.text = genreName
        } else {
            labelGenre.text = "-"
        }
        imageRequest?.suspend()
        imageViewPoster.image = #imageLiteral(resourceName: "defaultPosterImage")
        downloadedImage = nil
        if let posterPath = item.posterPath {
            imageRequest = Request.shared.IMAGE(path: posterPath) { (image) in
                self.imageRequest = nil
                if let image = image {
                    self.downloadedImage = image
                    self.imageViewPoster.image = image
                }
            }
        }
    }
}
