//
//  Movie.swift
//  TMDB
//
//  Created by Matheus Cardoso Kuhn on 06.08.22.
//

import Foundation

struct Movie: Identifiable {
    let id = UUID()
    let imgName: String
    let title: String
    let genre: String
    let releaseDate: String

    static func mockData(rows: Int) -> [Movie] {
        Array(0...rows).map { index in
            Movie(imgName: "placeholder_movie",
                                title: "Pasteleiro \(index)",
                                genre: "Culinária",
                                releaseDate: "06/08/\(2022 + index)")
        }
    }
}
