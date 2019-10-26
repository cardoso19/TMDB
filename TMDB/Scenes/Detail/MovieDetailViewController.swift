//
//  MovieDetailViewController.swift
//  TMDB
//
//  Created by Matheus Cardoso kuhn on 28/08/2018.
//  Copyright © 2018 MDT. All rights reserved.
//

import UIKit

protocol MovieDetailViewControllerDisplayLogic: AnyObject {
    func displayMovie(content: MovieDetailViewModel)
    func displayPoster(image: UIImage)
    func displayError(message: String)
}

class MovieDetailViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var imageViewPoster: UIImageView!
    @IBOutlet weak var labelGenre: UILabel!
    @IBOutlet weak var labelReleaseDate: UILabel!
    @IBOutlet weak var textViewOverview: UITextView!

    // MARK: - Variables
    var router: MovieDetailRouter?
    private var interactor: MovieDetailInteractor!
    private var isLayoutDefined: Bool = false

    // MARK: - Life Cycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = Colors.green
        navigationController?.isNavigationBarHidden = false
        interactor.showMovieContent()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = true
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if !isLayoutDefined {
            isLayoutDefined = true
            configLayout()
        }
    }

    private func setup() {
        let presenter = MovieDetailPresenterImpl()
        let dataStore = MovieDetailDataStoreImpl()
        let router = MovieDetailRouterImpl(dataStore: dataStore)
        let gateway = MovieDetailGatewayImpl(httpRequest: HttpRequest())
        let adapter = MovieDetailAdapterImpl()
        let interactor = MovieDetailInteractorImpl(presenter: presenter,
                                                   gateway: gateway,
                                                   dataStore: dataStore,
                                                   adapter: adapter)
        presenter.viewController = self
        self.interactor = interactor
        self.router = router
    }

    private func configLayout() {
        imageViewPoster.dropShadow()
    }
}

// MARK: - MovieDetailViewControllerDisplayLogic
extension MovieDetailViewController: MovieDetailViewControllerDisplayLogic {

    func displayMovie(content: MovieDetailViewModel) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.navigationItem.title = content.title
            self.labelGenre.text = content.genre
            self.labelReleaseDate.text = content.releaseDate
            self.textViewOverview.text = content.overview
        }
    }

    func displayPoster(image: UIImage) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.imageViewPoster.image = image
        }
    }

    func displayError(message: String) {
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
