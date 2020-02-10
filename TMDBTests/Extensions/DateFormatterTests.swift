//
//  DateFormatterTests.swift
//  TMDBTests
//
//  Created by Matheus Cardoso Kuhn on 09/02/20.
//  Copyright © 2020 MDT. All rights reserved.
//

import XCTest
@testable import TMDB

final class DateFormatterTests: XCTestCase {

    // MARK: - convertToString
    func testConvertToStringShouldReturnFormatedString() {
        let date = Date(timeIntervalSince1970: 1602212400)
        let format = "dd/MM/YYYY"
        let formattedDate = date.convertToString(format: format)
        XCTAssertEqual(formattedDate, "09/10/2020")
    }
}
