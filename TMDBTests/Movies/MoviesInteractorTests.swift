//
//  MoviesInteractorTests.swift
//  TMDBTests
//
//  Created by Matheus Cardoso Kuhn on 09/02/20.
//  Copyright © 2020 MDT. All rights reserved.
//

import XCTest
@testable import TMDB

// MARK: - MoviePresenterSpy
private final class MoviePresenterSpy: MoviesPresenting {

    private(set) var presentMoviesCallCount: Int = 0
    private(set) var movies: [Movies.Movie]?
    private(set) var presentErrorCallCount: Int = 0
    private(set) var error: RequestError?

    func presentMovies(_ movies: [Movies.Movie]) {
        presentMoviesCallCount += 1
        self.movies = movies
    }

    func presentError(_ error: RequestError) {
        presentErrorCallCount += 1
        self.error = error
    }
}

// MARK: - GenrePresenterSpy
private final class GenrePresenterSpy: GenrePresenting {

    private(set) var presentGenreErrorCallCount: Int = 0
    private(set) var error: RequestError?

    func presentGenreError(error: RequestError) {
        presentGenreErrorCallCount += 1
        self.error = error
    }
}

// MARK: - MoviesGatewaySpy
private final class MoviesGatewaySpy: MoviesGatewayLogic {

    var responseGenres: Result<GenresResponse, RequestError>?
    var responseMovies: Result<MoviesResponse, RequestError>?
    private(set) var fetchGenresCallCount: Int = 0
    private(set) var fetchMoviesCallCount: Int = 0

    func fetchGenres(completion: @escaping (Result<GenresResponse, RequestError>) -> Void) {
        fetchGenresCallCount += 1
        guard let responseGenres = responseGenres else { return }
        completion(responseGenres)
    }

    func fetchMovies(page: Int, completion: @escaping (Result<MoviesResponse, RequestError>) -> Void) {
        fetchMoviesCallCount += 1
        guard let responseMovies = responseMovies else { return }
        completion(responseMovies)
    }
}

// MARK: - GenreResponse+Equatable
extension GenreResponse: Equatable {
    public static func == (lhs: GenreResponse, rhs: GenreResponse) -> Bool {
        guard lhs.id == rhs.id else {
            return false
        }
        return true
    }
}

final class MoviesInteractorTests: XCTestCase {

    // MARK: - Variables
    private lazy var moviePresenter: MoviePresenterSpy = MoviePresenterSpy()
    private lazy var genrePresenter: GenrePresenterSpy = GenrePresenterSpy()
    private lazy var moviesGateway: MoviesGatewaySpy = MoviesGatewaySpy()
    private lazy var moviesDataStore: MoviesDataStore = MoviesDataStore()
    private lazy var serviceDataStore: MoviesServiceDataStore = MoviesServiceDataStore()
    private lazy var interactor: MoviesInteractor = {
        return MoviesInteractor(
            moviesPresenter: moviePresenter,
            genrePresenter: genrePresenter,
            gateway: moviesGateway,
            moviesDataStore: moviesDataStore,
            serviceDataStore: serviceDataStore,
            adapter: MoviesAdapter()
        )
    }()

    // MARK: - fetchGenres
    func testFetchGenresShouldCallSuccessFlowWhenReceiveResultSuccess() {
        let genresResponse = [GenreResponse(id: 0, name: "Test")]
        let response = GenresResponse(genres: genresResponse)
        moviesGateway.responseGenres = .success(response)
        interactor.fetchGenres()
        XCTAssertEqual(moviesGateway.fetchGenresCallCount, 1)
        XCTAssertEqual(moviesGateway.fetchMoviesCallCount, 1)
        XCTAssertEqual(moviesDataStore.genres.count, genresResponse.count)
        guard moviesDataStore.genres.count == genresResponse.count else {
            XCTFail("The genre arrays don't have the same size.")
            return
        }
        for (index, genre) in moviesDataStore.genres.enumerated() {
            XCTAssertEqual(genre, genresResponse[index])
        }
    }
}
