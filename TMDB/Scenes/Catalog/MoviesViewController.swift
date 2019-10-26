//
//  MoviesViewController.swift
//  TMDB
//
//  Created by Matheus Cardoso kuhn on 26/08/2018.
//  Copyright © 2018 MDT. All rights reserved.
//

import UIKit
import MDTAlert

protocol MoviesViewControllerDisplayLogic: AnyObject {
    func displayGenresError(message: String)
    func displayMovies(movies: [MovieViewModel])
    func displayMoviesError(message: String)
}

class MoviesViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var viewHeaderSafeArea: UIView!
    @IBOutlet weak var viewHeader: UIView!
    @IBOutlet weak var imageViewIcon: UIImageView!

    // MARK: - Variables
    private let interactor: MoviesInteractor
    let router: MoviesRouter
    var collectionController: MoviesCollectionLogic?
    var movies: [MovieViewModel] = []

    // MARK: - Life Cycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        let presenter = MoviesPresenterImpl()
        let gateway = MoviesGateway(httpRequest: HttpRequest())
        let dataStore = MoviesDataStoreImpl()
        let router = MoviesRouterImpl(dataStore: dataStore)
        let adapter = MoviesAdapterImpl()
        interactor = MoviesInteractorImpl(presenter: presenter,
                                      gateway: gateway,
                                      dataStore: dataStore,
                                      adapter: adapter)
        self.router = router
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        presenter.viewController = self
    }

    required init?(coder: NSCoder) {
        let presenter = MoviesPresenterImpl()
        let gateway = MoviesGateway(httpRequest: HttpRequest())
        let dataStore = MoviesDataStoreImpl()
        let router = MoviesRouterImpl(dataStore: dataStore)
        let adapter = MoviesAdapterImpl()
        interactor = MoviesInteractorImpl(presenter: presenter,
                                      gateway: gateway,
                                      dataStore: dataStore,
                                      adapter: adapter)
        self.router = router
        super.init(coder: coder)
        presenter.viewController = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        MDTLoading.showDefaultLoader()
        interactor.fetchGenres()
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        if identifier == "collection", let controller = segue.destination as? MoviesCollectionViewController {
            controller.moviesController = self
            collectionController = controller
        }
    }
}

// MARK: - MoviesController
extension MoviesViewController: MoviesController {

    func reachedTheEndOfList() {
        interactor.fetchMovies()
    }

    func detail(movieIndex: Int) {
        tabBarController?.performSegue(withIdentifier: "detailMovie",
                                       sender: (source: router,
                                                selectedIndex: movieIndex))
    }
}

// MARK: - MoviesViewControllerDisplayLogic
extension MoviesViewController: MoviesViewControllerDisplayLogic {

    func displayGenresError(message: String) {
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

    func displayMovies(movies: [MovieViewModel]) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.movies.append(contentsOf: movies)
            self.collectionController?.updateMovies(self.movies)
            MDTLoading.hideDefaultLoading()
        }
    }

    func displayMoviesError(message: String) {
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
