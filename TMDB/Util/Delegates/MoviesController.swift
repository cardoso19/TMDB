//
//  MoviesController.swift
//  TMDB
//
//  Created by Matheus Cardoso kuhn on 28/08/2018.
//  Copyright © 2018 MDT. All rights reserved.
//

import UIKit

protocol MoviesController: AnyObject {
    func reachedTheEndOfList()
    func detail(movieIndex: Int)
}
