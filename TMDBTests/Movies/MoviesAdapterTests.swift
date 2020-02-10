//
//  MoviesAdapterTests.swift
//  TMDBTests
//
//  Created by Matheus Cardoso Kuhn on 09/02/20.
//  Copyright © 2020 MDT. All rights reserved.
//

import XCTest
@testable import TMDB

final class MoviesAdapterTests: XCTestCase {

    // MARK: - Variables
    private lazy var adapter: MoviesAdapter = MoviesAdapter()

    // MARK: - transformMovie
    func testTransformMovieShouldReturnTheGivenData() {
        let responseMock = MovieResponse(
            identifier: nil,
            title: "Title",
            genreIDs: nil,
            posterPath: "PosterPath",
            backdropPath: nil,
            releaseDate: DateDecodable(value: Date()),
            overview: nil
        )
        let genre = "Test"
        let movieViewModel = adapter.transform(movie: responseMock, genre: genre)
        XCTAssertEqual(movieViewModel.genre, genre)
        XCTAssertEqual(movieViewModel.title, responseMock.title)
        XCTAssertEqual(movieViewModel.releaseDate, responseMock.releaseDate?.value)
        XCTAssertEqual(movieViewModel.posterPath, responseMock.posterPath)
    }
}
