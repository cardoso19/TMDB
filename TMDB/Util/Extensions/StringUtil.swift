//
//  StringUtil.swift
//  TMDB
//
//  Created by Matheus Cardoso kuhn on 26/08/2018.
//  Copyright © 2018 MDT. All rights reserved.
//

import UIKit

extension String {
    /// Create a date by a string.
    /// - Parameter format: date format.
    public func toDate(format: String) -> Date? {
        let dateFormat: DateFormatter = DateFormatter()
        dateFormat.dateFormat = format
        dateFormat.locale = NSLocale.system
        let date: Date? = dateFormat.date(from: self)
        if date == nil && format == "yyyy/MM/dd" {
            dateFormat.dateFormat = "yyyy/MM/dd HH"
            return dateFormat.date(from: self + " 01")
        }
        return date
    }
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect,
                                            options: .usesLineFragmentOrigin,
                                            attributes: [.font: font],
                                            context: nil)
        return ceil(boundingBox.height)
    }
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect,
                                            options: .usesLineFragmentOrigin,
                                            attributes: [.font: font],
                                            context: nil)
        return ceil(boundingBox.width)
    }
}
