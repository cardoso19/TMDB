//
//  MovieDetailViewController.swift
//  TMDB
//
//  Created by Matheus Cardoso kuhn on 28/08/2018.
//  Copyright © 2018 MDT. All rights reserved.
//

import UIKit
import Alamofire

class MovieDetailViewController: UIViewController {
    //==--------------------------------==
    //MARK: - IBOutlets
    //==--------------------------------==
    @IBOutlet weak var imageViewPoster: UIImageView!
    
    @IBOutlet weak var labelGenre: UILabel!
    @IBOutlet weak var labelReleaseDate: UILabel!
    @IBOutlet weak var textViewOverview: UITextView!
    
    //==--------------------------------==
    //MARK: - Variables
    //==--------------------------------==
    var movieDetail: MovieDetail?
    var posterRequest: Alamofire.Request?
    
    //==--------------------------------==
    //MARK: - Init
    //==--------------------------------==
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = Colors.green
        navigationController?.isNavigationBarHidden = false
        
        loadMovieTexts()
        loadMovieImage()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = true
        posterRequest?.cancel()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if !isLayoutDefined {
            isLayoutDefined = true
            configLayout()
        }
    }
    
    func configLayout() {
        imageViewPoster.dropShadow()
    }
    
    func loadMovieImage() {
        imageViewPoster.image = #imageLiteral(resourceName: "defaultPosterImage")
        if let image = movieDetail?.poster {
            imageViewPoster.image = image
        } else if let posterPath = movieDetail?.movie.poster_path {
            posterRequest = Request.shared.IMAGE(path: posterPath) { (image) in
                self.posterRequest = nil
                if let image = image {
                    self.imageViewPoster.image = image
                }
            }
        }
    }
    
    func loadMovieTexts() {
        navigationItem.title = movieDetail?.movie.title
        
        if let genreID = movieDetail?.movie.genre_ids?.first, let genreName = MDTGenres.shared.getMovieGenreBy(genreID: genreID) {
            labelGenre.text = genreName
        } else {
            labelGenre.text = "-"
        }
        if let date = movieDetail?.movie.release_date?.toDate(format: "yyyy/MM/dd") {
            labelReleaseDate.text = date.dateString(ofStyle: .short)
        } else {
            labelReleaseDate.text = "-/-/-"
        }
        if let overview = movieDetail?.movie.overview, overview != "" {
            textViewOverview.text = overview
        } else {
            textViewOverview.text = NSLocalizedString("NO OVERVIEW", comment: "")
        }
    }
}
