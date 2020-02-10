//
//  UISearchBarLoaderTests.swift
//  TMDBTests
//
//  Created by Matheus Cardoso Kuhn on 09/02/20.
//  Copyright © 2020 MDT. All rights reserved.
//

import XCTest
@testable import TMDB

final class UISearchBarLoaderTests: XCTestCase {

    // MARK: - Variables
    private lazy var searchBar: UISearchBar = UISearchBar(frame: .zero)

    // MARK: - isLoading
    func testIsLoadingShouldReturnTrueWhenTheLoadingValueIsTrue() {
        searchBar.isLoading = true
        XCTAssert(searchBar.isLoading)
    }

    func testIsLoadingShouldReturnFalseWhenTheLoadingValueWasTrueAndNowIsFalse() {
        searchBar.isLoading = true
        searchBar.isLoading = false
        XCTAssertFalse(searchBar.isLoading)
    }
}
