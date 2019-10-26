//
//  GenreResponse.swift
//  TMDB
//
//  Created by Matheus Cardoso kuhn on 26/08/2018.
//  Copyright © 2018 MDT. All rights reserved.
//

import Foundation

// swiftlint:disable identifier_name
struct GenreResponse: Decodable {
    let id: Int?
    let name: String?
}
