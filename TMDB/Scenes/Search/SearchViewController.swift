//
//  SearchViewController.swift
//  TMDB
//
//  Created by Matheus Cardoso kuhn on 26/08/2018.
//  Copyright © 2018 MDT. All rights reserved.
//

import UIKit
import MDTAlert

class SearchViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var viewHeaderSafeArea: UIView!
    @IBOutlet weak var viewHeader: UIView!
    @IBOutlet weak var viewSearchBarSafeAreaLeft: UIView!
    @IBOutlet weak var viewSearchBarSafeAreaRight: UIView!
    @IBOutlet weak var searchBar: UISearchBar!

    // MARK: - Variables
    private let interactor: SearchInteractor
    let router: SearchRouter & MovieDetailPassingData
    weak var collectionController: MoviesCollectionLogic?
    var movies: [Movies.MovieViewModel] = []

    // MARK: - Life Cycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        let moviesPresenter = MoviesPresenterImpl()
        let gateway = SearchGatewayImpl(httpRequest: HttpRequest())
        let searchDataStore = SearchDataStoreImpl()
        let moviesDataStore = MoviesDataStoreImpl()
        let moviesServiceDataStore = MoviesServiceDataStoreImpl()
        let adapter = MoviesAdapterImpl()
        router = SearchRouterImpl(searchDataStore: searchDataStore,
                                  moviesDataStore: moviesDataStore,
                                  moviesServiceDataStore: moviesServiceDataStore)
        interactor = SearchInteractorImpl(moviesPresenter: moviesPresenter,
                                          gateway: gateway,
                                          searchDataStore: searchDataStore,
                                          moviesDataStore: moviesDataStore,
                                          moviesServiceDataStore: moviesServiceDataStore,
                                          moviesAdapter: adapter)
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        moviesPresenter.viewController = self
    }

    required init?(coder: NSCoder) {
        let moviesPresenter = MoviesPresenterImpl()
        let gateway = SearchGatewayImpl(httpRequest: HttpRequest())
        let searchDataStore = SearchDataStoreImpl()
        let moviesDataStore = MoviesDataStoreImpl()
        let moviesServiceDataStore = MoviesServiceDataStoreImpl()
        let adapter = MoviesAdapterImpl()
        router = SearchRouterImpl(searchDataStore: searchDataStore,
                                  moviesDataStore: moviesDataStore,
                                  moviesServiceDataStore: moviesServiceDataStore)
        interactor = SearchInteractorImpl(moviesPresenter: moviesPresenter,
                                          gateway: gateway,
                                          searchDataStore: searchDataStore,
                                          moviesDataStore: moviesDataStore,
                                          moviesServiceDataStore: moviesServiceDataStore,
                                          moviesAdapter: adapter)
        super.init(coder: coder)
        moviesPresenter.viewController = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareLayout()
    }

    private func prepareLayout() {
        searchBar.placeholder = NSLocalizedString("SEARCH", comment: "")
        searchBar.backgroundColor = Colors.darkGray
        searchBar.barTintColor = Colors.darkGray
        searchBar.tintColor = Colors.darkGray
        searchBar.becomeFirstResponder()
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
        interactor.doMoviesSearch(query: query)
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let query: String = searchBar.text ?? ""
        interactor.searchTextChange(query: query)
    }
}

// MARK: - MoviesController
extension SearchViewController: MoviesController {

    func reachedTheEndOfList() {
        let query: String = searchBar.text ?? ""
        interactor.doMoviesSearch(query: query)
    }

    func detail(movieIndex: Int) {
        tabBarController?.performSegue(withIdentifier: "detailMovie",
                                       sender: (source: router,
                                                selectedIndex: movieIndex))
    }
}

// MARK: - MoviesDisplayLogic
extension SearchViewController: MoviesDisplayLogic {

    func displayMovies(_ movies: [Movies.MovieViewModel]) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.collectionController?.updateMovies(movies)
        }
    }

    func displayError(message: String) {
        DispatchQueue.main.async {
            let alert = MDTAlertView(message: message,
                                        position: .top,
                                        dismissTime: 3)
            alert.present()
            MDTLoading.hideDefaultLoading()
        }
    }
}
