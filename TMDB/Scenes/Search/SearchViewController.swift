//
//  SearchViewController.swift
//  TMDB
//
//  Created by Matheus Cardoso kuhn on 26/08/2018.
//  Copyright © 2018 MDT. All rights reserved.
//

import UIKit

protocol SearchViewControllerDisplayLogic: AnyObject {
    func display(movies: [MovieViewModel])
    func display(message: String)
}

class SearchViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var viewHeaderSafeArea: UIView!
    @IBOutlet weak var viewHeader: UIView!
    @IBOutlet weak var viewSearchBarSafeAreaLeft: UIView!
    @IBOutlet weak var viewSearchBarSafeAreaRight: UIView!
    @IBOutlet weak var searchBar: UISearchBar!

    // MARK: - Variables
    private let interactor: SearchInteractor
    let router: SearchRouter
    weak var collectionController: MoviesCollectionLogic?
    var movies: [MovieViewModel] = []

    // MARK: - Life Cycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        let presenter = SearchPresenterImpl()
        let gateway = SearchGatewayImpl(httpRequest: HttpRequest())
        let dataStore = SearchDataStoreImpl()
        let adapter = SearchAdapterImpl()
        router = SearchRouterImpl(dataStore: dataStore)
        interactor = SearchInteractorImpl(presenter: presenter,
                                          gateway: gateway,
                                          dataStore: dataStore,
                                          adapter: adapter)
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        presenter.viewController = self
    }

    required init?(coder: NSCoder) {
        let presenter = SearchPresenterImpl()
        let gateway = SearchGatewayImpl(httpRequest: HttpRequest())
        let dataStore = SearchDataStoreImpl()
        let adapter = SearchAdapterImpl()
        router = SearchRouterImpl(dataStore: dataStore)
        interactor = SearchInteractorImpl(presenter: presenter,
                                          gateway: gateway,
                                          dataStore: dataStore,
                                          adapter: adapter)
        super.init(coder: coder)
        presenter.viewController = self
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

// MARK: - SearchViewControllerDisplayLogic
extension SearchViewController: SearchViewControllerDisplayLogic {

    func display(movies: [MovieViewModel]) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.collectionController?.updateMovies(movies)
        }
    }

    func display(message: String) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            let snackBar = SnackBarView.instanceFromNib(parentView: self.view,
                                                        message: message,
                                                        isError: true,
                                                        dismissTime: 3)
            snackBar?.show()
            MDTLoading.hideDefaultLoading()
        }
    }
}
