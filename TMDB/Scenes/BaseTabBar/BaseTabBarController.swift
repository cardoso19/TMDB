//
//  BaseTabBarController.swift
//  TMDB
//
//  Created by Matheus Cardoso kuhn on 26/08/2018.
//  Copyright © 2018 MDT. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController {

    // MARK: - Variables
    let router: BaseTabBarRouter

    // MARK: - Life Cycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.router = BaseTabBarRouterImpl()
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        delegate = self
    }

    required init?(coder: NSCoder) {
        self.router = BaseTabBarRouterImpl()
        super.init(coder: coder)
        delegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.backgroundColor = Colors.darkGray
        tabBar.barTintColor = Colors.darkGray
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier, identifier == "detailMovie" {
            guard
                let destination = segue.destination as? MovieDetailViewController,
                let destinationRouter = destination.router,
                let sender = sender as? (source: MovieDetailPassingData, selectedIndex: Int)
                else {
                    return
            }
            sender.source.passDetailData(destination: destinationRouter,
                                         selectedIndex: sender.selectedIndex)
        }
    }
}

// MARK: - UITabBarControllerDelegate
extension BaseTabBarController: UITabBarControllerDelegate {

    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if viewController is SearchViewController {
            guard
                let source = viewControllers?.filter({ $0 is MoviesViewController }).first as? MoviesViewController,
                let destination = viewController as? SearchViewController
                else {
                    return
            }
            router.passGenreData(sourceRouter: source.router, destination: destination.router)
        }
    }
}
