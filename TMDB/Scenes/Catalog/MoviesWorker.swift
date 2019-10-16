//
//  MoviesWorker.swift
//  TMDB
//
//  Created by Matheus Cardoso Kuhn on 11/10/19.
//  Copyright © 2019 MDT. All rights reserved.
//

import UIKit

protocol MoviesWorkerLogic {
    func fetchGenres(completion: @escaping (Result<GenresResponse, RequestError>) -> Void)
    func fetchMovies(page: Int, completion: @escaping (Result<MoviesResponse, RequestError>) -> Void)
    func downloadImage(posterUrl: String, completion: @escaping (Result<UIImage, RequestError>) -> Void)
}

class MoviesWorker: MoviesWorkerLogic {

    // MARK: - Variables
    private let httpRequest: HttpRequest

    // MARK: - Life Cycle
    init(httpRequest: HttpRequest) {
        self.httpRequest = httpRequest
    }

    func fetchGenres(completion: @escaping (Result<GenresResponse, RequestError>) -> Void) {
        let httpBody: [String: Encodable] = ["api_key": API.token,
                                             "language": Locale.preferredLanguages.first]
        let setup = RequestSetup(url: API.URL.base.rawValue + API.Path.genre.rawValue,
                                 cachePolicy: API.cachePolicy,
                                 timeoutInterval: API.timeoutInterval,
                                 httpMethod: .get,
                                 httpHeaders: nil,
                                 parameters: httpBody)
        httpRequest.request(with: setup) { result in
            DispatchQueue.global(qos: .userInteractive).async {
                completion(result)
            }
        }
    }

    func fetchMovies(page: Int, completion: @escaping (Result<MoviesResponse, RequestError>) -> Void) {
        let httpBody: [String: Encodable] = ["api_key": API.token,
                                             "language": Locale.preferredLanguages.first,
                                             "page": page]
        let setup = RequestSetup(url: API.URL.base.rawValue + API.Path.upcoming.rawValue,
                                 cachePolicy: API.cachePolicy,
                                 timeoutInterval: API.timeoutInterval,
                                 httpMethod: .get,
                                 httpHeaders: nil,
                                 parameters: httpBody)
        httpRequest.request(with: setup) { result in
            DispatchQueue.global(qos: .userInteractive).async {
                completion(result)
            }
        }
    }
    
    func downloadImage(posterUrl: String, completion: @escaping (Result<UIImage, RequestError>) -> Void) {
        let setup = ImageRequestSetup(url: API.URL.image.rawValue + posterUrl,
                                      cachePolicy: API.cachePolicy)
        httpRequest.downloadImage(with: setup) { result in
            DispatchQueue.global(qos: .userInteractive).async {
                completion(result)
            }
        }
    }
}
