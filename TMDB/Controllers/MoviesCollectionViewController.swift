//
//  MoviesCollectionViewController.swift
//  TMDB
//
//  Created by Matheus Cardoso kuhn on 28/08/2018.
//  Copyright © 2018 MDT. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

private let reuseIdentifier = "movieCell"

class MoviesCollectionViewController: UICollectionViewController {
    //==--------------------------------==
    // MARK: - Variables
    //==--------------------------------==
    var emptyContentText: String = NSLocalizedString("DO A SEARCH", comment: "")
    var moviesController: MoviesController?
    var movies: [Movie] = []
    //==--------------------------------==
    // MARK: - Init
    //==--------------------------------==
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
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //==--------------------------------==
    // MARK: - UIScrollViewDelegate
    //==--------------------------------==
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if movies.count > 0 && scrollView.contentSize.height > scrollView.frame.size.height {
            if scrollView.contentOffset.y + scrollView.frame.size.height >= scrollView.contentSize.height * 0.8 {
                moviesController?.reachedTheEndOfList()
            }
        }
    }
    //==--------------------------------==
    // MARK: - UICollectionViewDelegate
    //==--------------------------------==
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var detail: MovieDetail = MovieDetail(movie: movies[indexPath.row], poster: nil)
        if let image = (collectionView.cellForItem(at: indexPath) as? MovieCollectionViewCell)?.downloadedImage {
            detail.poster = image
        }
        moviesController?.detail(movie: detail)
    }
    //==--------------------------------==
    // MARK: - UICollectionViewDataSource
    //==--------------------------------==
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = createMovieCell(collectionView, indexPath: indexPath, data: movies[indexPath.row]) {
            return cell
        }
        return UICollectionViewCell()
    }
    //===----------------------------------------===//
    // MARK: - Cell Constructor
    //===----------------------------------------===//
    private func createMovieCell(_ collectionView: UICollectionView,
                                 indexPath: IndexPath,
                                 data: Movie) -> MovieCollectionViewCell? {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
                                                         for: indexPath) as? MovieCollectionViewCell {
            cell.setContent(item: data)
            return cell
        }
        return nil
    }
}

//==--------------------------------==
// MARK: - UICollectionViewDelegateFlowLayout
//==--------------------------------==
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

//==--------------------------------==
// MARK: - MoviesCollectionController
//==--------------------------------==
extension MoviesCollectionViewController: MoviesCollectionController {
    func updateMovies(_ movies: [Movie]) {
        self.movies = movies
        if movies.count == 0 {
            emptyContentText = NSLocalizedString("NO RESULT", comment: "")
        }
        collectionView?.reloadData()
    }
    func reloadData() {
        collectionView?.reloadData()
    }
}

//==--------------------------------==
// MARK: - DZNEmptyDataSetSource n DZNEmptyDataSetDelegate
//==--------------------------------==
extension MoviesCollectionViewController: DZNEmptyDataSetSource {
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        return NSAttributedString(string: emptyContentText)
    }
}
