//
//  MoviesGateway.swift
//  TMDB
//
//  Created by Matheus Cardoso Kuhn on 11/10/19.
//  Copyright © 2019 MDT. All rights reserved.
//

import UIKit

protocol MoviesGatewayLogic {
    func fetchGenres(completion: @escaping (Result<GenresResponse, RequestError>) -> Void)
    func fetchMovies(page: Int, completion: @escaping (Result<MoviesResponse, RequestError>) -> Void)
    func downloadImage(posterUrl: String, completion: @escaping (Result<UIImage, RequestError>) -> Void)
}

class MoviesGateway: MoviesGatewayLogic {

    // MARK: - Variables
    private let httpRequest: HttpRequest

    // MARK: - Life Cycle
    init(httpRequest: HttpRequest) {
        self.httpRequest = httpRequest
    }

    func fetchGenres(completion: @escaping (Result<GenresResponse, RequestError>) -> Void) {
        httpRequest.request(with: MoviesGatewaySetup.genre) { result in
            DispatchQueue.global(qos: .userInteractive).async {
                completion(result)
            }
        }
    }

    func fetchMovies(page: Int, completion: @escaping (Result<MoviesResponse, RequestError>) -> Void) {
        httpRequest.request(with: MoviesGatewaySetup.upcomingMovies(page: page)) { result in
            DispatchQueue.global(qos: .userInteractive).async {
                completion(result)
            }
        }
    }

    func downloadImage(posterUrl: String, completion: @escaping (Result<UIImage, RequestError>) -> Void) {
        httpRequest.downloadImage(with: ImageGatewaySetup.download(posterUrl: posterUrl)) { result in
            completion(result)
        }
    }
}
