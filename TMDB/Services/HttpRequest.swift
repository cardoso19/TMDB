//
//  HttpRequest.swift
//  TMDB
//
//  Created by Matheus Cardoso Kuhn on 14/10/19.
//  Copyright © 2019 MDT. All rights reserved.
//

import Foundation

protocol RequestSetup {
    var endpoint: String { get }
}

protocol RequestProtocol {
    func request<T: Decodable>(with setup: RequestSetup, completion: @escaping (Result<T,NSError>) -> Void)
}

class HttpRequest: RequestProtocol {
    
    // MARK: - Variables
    private let session: URLSessionProtocol
    
    // MARK: - Life Cycle
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    // MARK: - Request
    func request<T: Decodable>(with setup: RequestSetup, completion: @escaping (Result<T, NSError>) -> Void) {
        guard let url = URL(string: setup.endpoint) else {
            return completion(.failure(NSError()))
        }
    }
}
