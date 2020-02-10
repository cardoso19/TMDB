//
//  StringFormatterTests.swift
//  TMDBTests
//
//  Created by Matheus Cardoso Kuhn on 09/02/20.
//  Copyright © 2020 MDT. All rights reserved.
//

import XCTest

final class StringFormatterTests: XCTestCase {

    // MARK: - convertToDate
    func testConvertToDateShouldReturnADateWithTheSameValueWhenReceiveProperEntries() {
        let stringDate = "01/01/2020"
        let format = "dd/MM/yyyy"
        let response = stringDate.convertToDate(format: format)
        XCTAssertNotNil(response)
        XCTAssertEqual(response?.convertToString(format: format), stringDate)
    }

    func testConvertToDateShouldReturnNilWhenReceiveNotValidStringDate() {
        let stringDate = "01/dd/2020"
        let format = "dd/MM/yyyy"
        let response = stringDate.convertToDate(format: format)
        XCTAssertNil(response)
    }

    func testConvertToDateShouldReturnNilWhenReceiveStringDateThatDoesntMatchWithFormat() {
        let stringDate = "01/01/2020 - 12:00"
        let format = "dd/MM/yyyy"
        let response = stringDate.convertToDate(format: format)
        XCTAssertNil(response)
    }
}
