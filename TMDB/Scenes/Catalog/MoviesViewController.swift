//
//  MoviesViewController.swift
//  TMDB
//
//  Created by Matheus Cardoso kuhn on 26/08/2018.
//  Copyright © 2018 MDT. All rights reserved.
//

import UIKit
import MDTAlert

protocol MoviesDisplayLogic: AnyObject {
    func displayMovies(_ movies: [Movies.MovieViewModel])
    func displayError(message: String)
}

protocol GenreDisplayLogic: AnyObject {
    func displayError(message: String)
}

final class MoviesViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var viewHeaderSafeArea: UIView!
    @IBOutlet weak var viewHeader: UIView!
    @IBOutlet weak var imageViewIcon: UIImageView!

    // MARK: - Variables
    private let interactor: MoviesInteracting
    let router: MoviesRouting & MovieDetailDataPassing
    var collectionController: MoviesCollectionLogic?
    var movies: [Movies.MovieViewModel] = []

    // MARK: - Life Cycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        let moviesPresenter = MoviesPresenter()
        let genrePresenter = GenrePresenter()
        let gateway = MoviesGateway(httpRequest: HttpRequest())
        let moviesDataStore = MoviesDataStore()
        let moviesServiceDataStore = MoviesServiceDataStore()
        let router = MoviesRouter(moviesDataStore: moviesDataStore,
                                      moviesServiceDataStore: moviesServiceDataStore)
        let adapter = MoviesAdapter()
        interactor = MoviesInteractor(moviesPresenter: moviesPresenter,
                                          genrePresenter: genrePresenter,
                                          gateway: gateway,
                                          moviesDataStore: moviesDataStore,
                                          serviceDataStore: moviesServiceDataStore,
                                          adapter: adapter)
        self.router = router
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        moviesPresenter.viewController = self
        genrePresenter.viewController = self
    }

    required init?(coder: NSCoder) {
        let moviesPresenter = MoviesPresenter()
        let genrePresenter = GenrePresenter()
        let gateway = MoviesGateway(httpRequest: HttpRequest())
        let moviesDataStore = MoviesDataStore()
        let moviesServiceDataStore = MoviesServiceDataStore()
        let router = MoviesRouter(moviesDataStore: moviesDataStore,
                                      moviesServiceDataStore: moviesServiceDataStore)
        let adapter = MoviesAdapter()
        interactor = MoviesInteractor(moviesPresenter: moviesPresenter,
                                          genrePresenter: genrePresenter,
                                          gateway: gateway,
                                          moviesDataStore: moviesDataStore,
                                          serviceDataStore: moviesServiceDataStore,
                                          adapter: adapter)
        self.router = router
        super.init(coder: coder)
        moviesPresenter.viewController = self
        genrePresenter.viewController = self
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

    // MARK: - Alert
    private func showAlert(message: String) {
        let alert = MDTAlertView(message: message,
                                    position: .top,
                                    dismissTime: 3)
        alert.present()
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

// MARK: - MoviesDisplayLogic
extension MoviesViewController: MoviesDisplayLogic {

    func displayMovies(_ movies: [Movies.MovieViewModel]) {
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
            self.showAlert(message: message)
            MDTLoading.hideDefaultLoading()
        }
    }
}

// MARK: - GenreDisplayLogic
extension MoviesViewController: GenreDisplayLogic {

    func displayError(message: String) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.showAlert(message: message)
            MDTLoading.hideDefaultLoading()
        }
    }
}
