//
//  MovieDetailGateway.swift
//  TMDB
//
//  Created by Matheus Cardoso Kuhn on 21/10/19.
//  Copyright © 2019 MDT. All rights reserved.
//

import UIKit

protocol MovieDetailGateway {
    func downloadImage(posterUrl: String, completion: @escaping (Result<UIImage, RequestError>) -> Void)
}

class MovieDetailGatewayImpl: MovieDetailGateway {

    // MARK: - Variables
    private let httpRequest: HttpRequest

    // MARK: - Life Cycle
    init(httpRequest: HttpRequest) {
        self.httpRequest = httpRequest
    }

    // MARK: - Image
    func downloadImage(posterUrl: String, completion: @escaping (Result<UIImage, RequestError>) -> Void) {
        httpRequest.downloadImage(with: ImageGatewaySetup.download(posterUrl: posterUrl)) { result in
            DispatchQueue.global().async {
                completion(result)
            }
        }
    }
}
