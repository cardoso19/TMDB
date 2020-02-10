//
//  String+Formatter.swift
//  TMDB
//
//  Created by Matheus Cardoso kuhn on 26/08/2018.
//  Copyright © 2018 MDT. All rights reserved.
//

import UIKit

extension String {

    /// Try to convert the string to date in the given format.
    /// - Parameter format: date's final format.
    public func convertToDate(format: String) -> Date? {
        let dateFormat: DateFormatter = DateFormatter()
        dateFormat.dateFormat = format
        dateFormat.locale = Locale(identifier: "en_US_POSIX")
        return dateFormat.date(from: self)
    }
}
