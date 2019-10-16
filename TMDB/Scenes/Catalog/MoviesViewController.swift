//
//  MoviesViewController.swift
//  TMDB
//
//  Created by Matheus Cardoso kuhn on 26/08/2018.
//  Copyright © 2018 MDT. All rights reserved.
//

import UIKit
import MDTAlert

protocol MoviesViewControllerLogic: AnyObject {
    func displayGenresError(message: String)
    func displayMovies(movies: [MovieViewModel])
    func displayMoviesError(message: String)
    func displayLoader(isVisible: Bool)
}

class MoviesViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var viewHeaderSafeArea: UIView!
    @IBOutlet weak var viewHeader: UIView!
    @IBOutlet weak var imageViewIcon: UIImageView!

    // MARK: - Variables
    private var interactor: MoviesInteractorLogic!
    private var router: MoviesRouterLogic!
    var collectionController: MoviesCollectionController?
    var movies: [MovieViewModel] = []

    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        interactor.fetchGenres()
    }

    private func setup() {
        let presenter = MoviesPresenter()
        let worker = MoviesWorker(httpRequest: HttpRequest())
        let dataStore = MoviesDataStore()
        let router = MoviesRouter()
        let adapter = MoviesAdapter()
        router.dataStore = dataStore
        presenter.viewController = self
        interactor = MoviesInteractor(presenter: presenter,
                                      worker: worker,
                                      dataStore: dataStore,
                                      adapter: adapter)
        self.router = router
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

// MARK: - MoviesController
extension MoviesViewController: MoviesController {

    func reachedTheEndOfList() {
        interactor.fetchMovies()
    }

    func detail(movie: MovieDetail) {
        tabBarController?.performSegue(withIdentifier: "detailMovie", sender: movie)
    }
}

// MARK: - MoviesViewControllerLogic
extension MoviesViewController: MoviesViewControllerLogic {

    func displayGenresError(message: String) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            let snackBar = SnackBarView.instanceFromNib(parentView: self.view,
                                                        message: message,
                                                        isError: true,
                                                        dismissTime: 3)
            snackBar?.show()
        }
    }

    func displayMovies(movies: [MovieViewModel]) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.movies.append(contentsOf: movies)
            self.collectionController?.updateMovies(self.movies)
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
        }
    }

    func displayLoader(isVisible: Bool) {
        DispatchQueue.main.async {
            if isVisible {
                MDTLoading.showDefaultLoader()
            } else {
                MDTLoading.hideDefaultLoading()
            }
        }
    }
}
