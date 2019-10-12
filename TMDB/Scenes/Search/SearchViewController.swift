//
//  SearchViewController.swift
//  TMDB
//
//  Created by Matheus Cardoso kuhn on 26/08/2018.
//  Copyright © 2018 MDT. All rights reserved.
//

import UIKit
import Alamofire

class SearchViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var viewHeaderSafeArea: UIView!
    @IBOutlet weak var viewHeader: UIView!
    @IBOutlet weak var viewSearchBarSafeAreaLeft: UIView!
    @IBOutlet weak var viewSearchBarSafeAreaRight: UIView!
    @IBOutlet weak var searchBar: UISearchBar!

    // MARK: - Variables
    var collectionController: MoviesCollectionController?
    var movies: [Movie] = []
    var currentPage: Int = 0
    var totalPages: Int = 0
    var isRequesting: Bool = false
    var searchRequest: Alamofire.Request?
    var previousSearchedQuery: String?
    var timer: Timer?

    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.placeholder = NSLocalizedString("SEARCH", comment: "")
        searchBar.backgroundColor = Colors.darkGray
        searchBar.barTintColor = Colors.darkGray
        searchBar.tintColor = Colors.darkGray
        searchBar.becomeFirstResponder()
    }

    // MARK: - IBActions
    func callSearchMovies() {
        let query: String = searchBar.text ?? ""
        if !isRequesting && (totalPages == 0 || currentPage <= totalPages) && query != "" {
            if currentPage == 0 {
                searchBar.isLoading = true
            }
            isRequesting = true
            previousSearchedQuery = query
            searchRequest = SearchServices.getMoviesBy(query: query,
                                                       page: currentPage + 1) { (response, error) in
                                                        self.isRequesting = false
                                                        if self.currentPage == 0 {
                                                            self.searchBar.isLoading = false
                                                        }
                                                        if let error = error {
                                                            MDTAlert.shared.showSnackBar(message: error.message ?? "",
                                                                                         isError: true)
                                                        } else if let response = response,
                                                            let newMovies = response.results {
                                                            if self.currentPage == 0 {
                                                                self.movies = newMovies
                                                            } else {
                                                                self.movies.append(contentsOf: newMovies)
                                                            }
                                                            self.totalPages = response.totalPages ?? -1
                                                            self.currentPage += 1
//                                                            self.collectionController?.updateMovies(self.movies)
                                                        }
            }
        }
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier,
            identifier == "collection",
            let controller = segue.destination as? MoviesCollectionViewController {
            controller.moviesController = self
            collectionController = controller
        }
    }
}

// MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        let query: String = searchBar.text ?? ""
        if query != (previousSearchedQuery ?? "-1") {
            callSearchMovies()
        }
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        timer?.invalidate()
        currentPage = 0
        totalPages = 0
        searchRequest?.suspend()
        isRequesting = false
        searchBar.isLoading = false
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
            self.callSearchMovies()
        })
    }
}

// MARK: - MoviesController
extension SearchViewController: MoviesController {

    func reachedTheEndOfList() {
        callSearchMovies()
    }

    func detail(movie: MovieDetail) {
        tabBarController?.performSegue(withIdentifier: "detailMovie", sender: movie)
    }
}
