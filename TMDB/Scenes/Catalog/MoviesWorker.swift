//
//  MoviesWorker.swift
//  TMDB
//
//  Created by Matheus Cardoso Kuhn on 11/10/19.
//  Copyright © 2019 MDT. All rights reserved.
//

import Foundation

protocol MoviesWorkerLogic {
    func fetchGenres(completion: @escaping (Result<[GenreResponse], NSError>) -> Void)
    func fetchMovies(page: Int, completion: @escaping (Result<MoviesResponse, NSError>) -> Void)
}

class MoviesWorker: MoviesWorkerLogic {
    func fetchGenres(completion: @escaping (Result<[GenreResponse], NSError>) -> Void) {
        GenreServices.getGenres { (response, error) in
            DispatchQueue.global(qos: .userInitiated).async {
                if let error = error {
                    completion(.failure(NSError(domain: "Error",
                                                code: error.code ?? -1,
                                                userInfo: ["message": error.message ?? ""])))
                } else if let genres = response {
                    completion(.success(genres))
                }
            }
        }
    }

    func fetchMovies(page: Int, completion: @escaping (Result<MoviesResponse, NSError>) -> Void) {
        MovieServices.getUPComingMovies(page: page) { (response, error) in
            DispatchQueue.global(qos: .userInitiated).async {
                if let error = error {
                    completion(.failure(NSError(domain: "Error",
                    code: error.code ?? -1,
                    userInfo: ["message": error.message ?? ""])))
                } else if let response = response {
                    completion(.success(response))
                }
            }
        }
    }
}
