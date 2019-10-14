//
//  SearchServices.swift
//  TMDB
//
//  Created by Matheus Cardoso kuhn on 28/08/2018.
//  Copyright © 2018 MDT. All rights reserved.
//

import Foundation

class SearchServices {
    static func getMoviesBy(query: String,
                            page: Int,
                            completion: @escaping (_ response: MoviesResponse?,
                                                   _ error: ErrorObject?) -> Void) -> Alamofire.Request {
        let basePath: String = "search/movie?"
        let apiKey: String = String(format: "api_key=%@", MDTConstants.apiKey)
        let language: String = String(format: "language=%@", MDTCurrentDevice.language)
        let query: String = String(format: "query=%@", query)
        let page: String = String(format: "page=%d", page)
        var path: String = basePath + apiKey + "&" + language + "&"
        path += query + "&" + page + "&" + "include_adult=false"
        return Request.shared.JSON(path: path,
                                   method: .get,
                                   parameters: nil,
                                   headers: nil) { (response: MoviesResponse?, error) in
                                    completion(response, error)
        }
    }
}
