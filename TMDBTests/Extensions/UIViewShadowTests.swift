//
//  UIViewShadowTests.swift
//  TMDBTests
//
//  Created by Matheus Cardoso Kuhn on 09/02/20.
//  Copyright © 2020 MDT. All rights reserved.
//

import XCTest
@testable import TMDB

final class UIViewShadowTests: XCTestCase {

    // MARK: - Variables
    private var view: UIView = UIView(frame: .zero)

    // MARK: - dropShadow
    func testDropShadowShouldDefineValueAsGivenAndUIScreenMainScaleInRasterizationScaleWhenScaleIsTrue() {
        let color: UIColor = .red
        let opacity: Float = 1.0
        view.dropShadow(scale: true, path: nil, shadowColor: color, opacity: opacity)
        XCTAssertEqual(view.layer.rasterizationScale, UIScreen.main.scale)
        XCTAssertNil(view.layer.shadowPath)
        XCTAssertEqual(view.layer.shadowColor, color.cgColor)
        XCTAssertEqual(view.layer.shadowOpacity, opacity)
    }

    func testDropShadowShouldDefineValueAsGivenAndOneInRasterizationScaleWhenScaleIsFalse() {
        let color: UIColor = .yellow
        let opacity: Float = 0.5
        let path: CGPath = CGPath(rect: .zero, transform: nil)
        view.dropShadow(scale: false, path: path, shadowColor: color, opacity: opacity)
        XCTAssertEqual(view.layer.rasterizationScale, 1)
        XCTAssertEqual(view.layer.shadowPath, path)
        XCTAssertEqual(view.layer.shadowColor, color.cgColor)
        XCTAssertEqual(view.layer.shadowOpacity, opacity)
    }
}
