//
//  BaseTabBarController.swift
//  TMDB
//
//  Created by Matheus Cardoso kuhn on 26/08/2018.
//  Copyright © 2018 MDT. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController {
    //==--------------------------------==
    //MARK: - IBOutlets
    //==--------------------------------==
    
    //==--------------------------------==
    //MARK: - Init
    //==--------------------------------==
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.backgroundColor = Colors.darkGray
        tabBar.barTintColor = Colors.darkGray
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if !isLayoutDefined {
            isLayoutDefined = true
            configLayout()
        }
    }
    
    func configLayout() {
        
    }
    
    //==--------------------------------==
    //MARK: - IBActions
    //==--------------------------------==
    
    //==--------------------------------==
    //MARK: - Interactions
    //==--------------------------------==
    
    //==--------------------------------==
    //MARK: - Navigation
    //==--------------------------------==
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier, identifier == "detailMovie", let movie = sender as? MovieDetail, let controller = segue.destination as? MovieDetailViewController {
            controller.movieDetail = movie
        }
    }
}
