//
//  MovieServices.swift
//  TMDB
//
//  Created by Matheus Cardoso kuhn on 26/08/2018.
//  Copyright © 2018 MDT. All rights reserved.
//

import Foundation

class MovieServices {
    static func getUPComingMovies(page: Int,
                                  completion: @escaping (_ response: MoviesResponse?, _ error: ErrorObject?) -> Void) {
        _ = Request.shared.JSON(path: String(format: "movie/upcoming?api_key=%@&language=%@&page=%d",
                                             MDTConstants.apiKey,
                                             MDTCurrentDevice.language,
                                             page),
                                method: .get,
                                parameters: nil,
                                headers: nil) { (response: MoviesResponse?, error) in
                                    completion(response, error)
        }
    }
}
