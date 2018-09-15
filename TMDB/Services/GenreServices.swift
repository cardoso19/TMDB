//
//  GenreServices.swift
//  TMDB
//
//  Created by Matheus Cardoso kuhn on 26/08/2018.
//  Copyright © 2018 MDT. All rights reserved.
//

import Foundation

class GenreServices {
    static func getGenres(completion: @escaping (_ response: [Genre]?, _ error: ErrorObject?) -> Void) {
        _ = Request.shared.JSON(path: String(format: "genre/movie/list?api_key=%@&language=%@",
                                             MDTConstants.apiKey,
                                             MDTCurrentDevice.language),
                                method: .get,
                                parameters: nil,
                                headers: nil) { (response: GenresDTO?, error) in
                                    completion(response?.genres, error)
        }
    }
}
