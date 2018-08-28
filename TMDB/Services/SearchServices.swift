//
//  SearchServices.swift
//  TMDB
//
//  Created by Matheus Cardoso kuhn on 28/08/2018.
//  Copyright © 2018 MDT. All rights reserved.
//

import Foundation
import Alamofire

class SearchServices {
    static func getMoviesBy(query: String,
                            page: Int,
                            completion: @escaping (_ response: MoviesDTO?,_ error: ErrorObject?) -> Void) -> Alamofire.Request {
        return Request.shared.JSON(path: String(format: "search/movie?api_key=%@&language=%@&query=%@&page=%d&include_adult=false",
                                                MDTConstants.apiKey,
                                                MDTCurrentDevice.language,
                                                query,
                                                page),
                                   method: .get,
                                   parameters: nil,
                                   headers: nil) { (response: MoviesDTO?, error) in
                                    completion(response, error)
        }
    }
}
