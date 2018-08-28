//
//  MDTGenres.swift
//  TMDB
//
//  Created by Matheus Cardoso kuhn on 26/08/2018.
//  Copyright © 2018 MDT. All rights reserved.
//

import Foundation

class MDTGenres {
    //==--------------------------------==
    //MARK: - Variables n Init
    //==--------------------------------==
    static let shared: MDTGenres = MDTGenres()
    var genres: [Genre]?
    private init() {}
    
    //==--------------------------------==
    //MARK: - Get
    //==--------------------------------==
    func getMovieGenreBy(genreID: Int) -> String? {
        if let genres = genres {
            for genre in genres {
                if (genre.id ?? -1) == genreID {
                    return genre.name
                }
            }
        }
        return nil
    }
}
