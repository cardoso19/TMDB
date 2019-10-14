//
//  RequestError.swift
//  TMDB
//
//  Created by Matheus Cardoso Kuhn on 14/10/19.
//  Copyright © 2019 MDT. All rights reserved.
//

import Foundation

enum RequestError: Error {
    case urlNotFound
    case authenticationRequired
    case brokenData
    case couldNotFindHost
    case couldNotParseObject
    case badRequest
    case invalidHttpResponse
    case unknown(String)

    var localizedDescription: String {
        switch self {
        case .urlNotFound: return "Could not found URL."
        case .authenticationRequired: return "Authentication is required."
        case .brokenData: return "The received data is broken."
        case .couldNotFindHost: return "The host was not found."
        case .badRequest: return "This is a bad request."
        case .couldNotParseObject: return "Can't convert the data to the object entity."
        case .invalidHttpResponse: return "HTTPURLResponse is nil"
        case let .unknown(message): return message
        }
    }
}

extension RequestError: Equatable {
    static func ==(lhs: RequestError, rhs: RequestError) -> Bool {
        return lhs.localizedDescription == rhs.localizedDescription
    }
}
