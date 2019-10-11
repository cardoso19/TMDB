//
//  DateExtension.swift
//  TMDB
//
//  Created by Matheus Cardoso Kuhn on 10/10/19.
//  Copyright © 2019 MDT. All rights reserved.
//

import Foundation

extension Date {
    
    /// Convert the date to string in the given format.
    /// - Parameter format: strings' final format.
    public func convertToString(format: String) -> String {
        let dateFormat: DateFormatter = DateFormatter()
        dateFormat.dateFormat = format
        dateFormat.locale = Locale(identifier: "en_US_POSIX")
        return dateFormat.string(from: self)
    }
}
