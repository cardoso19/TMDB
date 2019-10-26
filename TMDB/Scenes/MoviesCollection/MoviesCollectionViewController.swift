//
//  MoviesCollectionViewController.swift
//  TMDB
//
//  Created by Matheus Cardoso kuhn on 28/08/2018.
//  Copyright © 2018 MDT. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

protocol MoviesCollectionLogic: AnyObject {
    func updateMovies(_ movies: [MovieViewModel])
    func reloadData()
}

class MoviesCollectionViewController: UICollectionViewController {

    // MARK: - Variables
    private let reuseIdentifier = "movieCell"
    private var emptyContentText: String = NSLocalizedString("DO A SEARCH", comment: "")
    weak var moviesController: MoviesController?
    var movies: [MovieViewModel] = []

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.emptyDataSetSource = self
        collectionView?.register(UINib(nibName: "MovieCollectionViewCell", bundle: nil),
                                 forCellWithReuseIdentifier: reuseIdentifier)
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        collectionView?.reloadData()
    }

    // MARK: - UIScrollViewDelegate
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if !movies.isEmpty && scrollView.contentSize.height > scrollView.frame.size.height {
            if scrollView.contentOffset.y + scrollView.frame.size.height >= scrollView.contentSize.height * 0.8 {
                moviesController?.reachedTheEndOfList()
            }
        }
    }

    // MARK: - UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        moviesController?.detail(movieIndex: indexPath.row)
    }

    // MARK: - UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
                                                         for: indexPath) as? MovieCollectionViewCell {
            let movie = movies[indexPath.row]
            cell.setContent(viewModel: movie)
            return cell
        }
        return UICollectionViewCell()
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MoviesCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout {
            let numberOfItemsPerRow: Int = UIDevice.current.orientation.isLandscape ? 4 : 2
            let totalSpace: CGFloat = flowLayout.sectionInset.left
                + flowLayout.sectionInset.right
                + (flowLayout.minimumInteritemSpacing * CGFloat(numberOfItemsPerRow - 1))
            let width: Int = Int((collectionView.bounds.width - totalSpace) / CGFloat(numberOfItemsPerRow))
            return CGSize(width: width, height: Int((278 / 182) * width) + 100)
        }
        return CGSize.zero
    }
}

// MARK: - MoviesCollectionLogic
extension MoviesCollectionViewController: MoviesCollectionLogic {

    func updateMovies(_ movies: [MovieViewModel]) {
        self.movies = movies
        if movies.isEmpty {
            emptyContentText = NSLocalizedString("NO RESULT", comment: "")
        }
        collectionView?.reloadData()
    }

    func reloadData() {
        collectionView?.reloadData()
    }
}

// MARK: - DZNEmptyDataSetSource
extension MoviesCollectionViewController: DZNEmptyDataSetSource {

    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        return NSAttributedString(string: emptyContentText)
    }
}
