//
//  SearchDataStore.swift
//  TMDB
//
//  Created by Matheus Cardoso Kuhn on 20/10/19.
//  Copyright © 2019 MDT. All rights reserved.
//

import Foundation

protocol SearchDataStoring: AnyObject {
    var previousSearchedQuery: String? { get set }
    var timer: Timer? { get set }
}

final class SearchDataStore: SearchDataStoring {
    var previousSearchedQuery: String?
    var timer: Timer?
}
