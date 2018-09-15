//
//  MoviesViewController.swift
//  TMDB
//
//  Created by Matheus Cardoso kuhn on 26/08/2018.
//  Copyright © 2018 MDT. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController {
    //==--------------------------------==
    // MARK: - IBOutlets
    //==--------------------------------==
    @IBOutlet weak var viewHeaderSafeArea: UIView!
    @IBOutlet weak var viewHeader: UIView!
    @IBOutlet weak var imageViewIcon: UIImageView!
    //==--------------------------------==
    // MARK: - Variables
    //==--------------------------------==
    var collectionController: MoviesCollectionController?
    var movies: [Movie] = []
    var currentPage: Int = 0
    var totalPages: Int = 0
    var isRequesting: Bool = false
    //==--------------------------------==
    // MARK: - Init
    //==--------------------------------==
    override func viewDidLoad() {
        super.viewDidLoad()
        callGenres()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        callMovies()
    }
    //==--------------------------------==
    // MARK: - Interactions
    //==--------------------------------==
    func callMovies() {
        if !isRequesting && (totalPages == 0 || currentPage <= totalPages) {
            if currentPage == 0 {
                MDTLoading.showDefaultLoader()
            }
            isRequesting = true
            MovieServices.getUPComingMovies(page: currentPage + 1) { (response, error) in
                self.isRequesting = false
                if self.currentPage == 0 {
                    MDTLoading.hideDefaultLoading()
                }
                if let error = error {
                    MDTAlert.shared.showSnackBar(message: error.message ?? "", isError: true)
                } else if let response = response, let newMovies = response.results {
                    self.totalPages = response.totalPages ?? -1
                    self.currentPage += 1
                    self.movies.append(contentsOf: newMovies)
                    self.collectionController?.updateMovies(self.movies)
                }
            }
        }
    }
    func callGenres() {
        GenreServices.getGenres { (response, error) in
            if let error = error {
                MDTAlert.shared.showSnackBar(message: error.message ?? "", isError: true)
            } else {
                MDTGenres.shared.genres = response
                self.collectionController?.reloadData()
            }
        }
    }
    //==--------------------------------==
    // MARK: - Navigation
    //==--------------------------------==
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier,
            identifier == "collection",
            let controller = segue.destination as? MoviesCollectionViewController {
            controller.moviesController = self
            collectionController = controller
        }
    }
}

//==--------------------------------==
// MARK: - MoviesController
//==--------------------------------==
extension MoviesViewController: MoviesController {
    func reachedTheEndOfList() {
        callMovies()
    }
    func detail(movie: MovieDetail) {
        tabBarController?.performSegue(withIdentifier: "detailMovie", sender: movie)
    }
}
