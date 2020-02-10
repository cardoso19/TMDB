//
//  SearchGateway.swift
//  TMDB
//
//  Created by Matheus Cardoso Kuhn on 20/10/19.
//  Copyright © 2019 MDT. All rights reserved.
//

import Foundation

protocol SearchGatewayLogic {
    func searchMovies(query: String, page: Int, completion: @escaping (Result<MoviesResponse, RequestError>) -> Void)
}

final class SearchGateway: SearchGatewayLogic {

    // MARK: - Variables
    private let httpRequest: HttpRequest

    // MARK: - Life Cycle
    init(httpRequest: HttpRequest) {
        self.httpRequest = httpRequest
    }

    // MARK: - Search
    func searchMovies(query: String, page: Int, completion: @escaping (Result<MoviesResponse, RequestError>) -> Void) {
        httpRequest.request(with: SearchGatewaySetup.searchMovie(query: query, page: page)) { result in
            DispatchQueue.global().async {
                completion(result)
            }
        }
    }
}
