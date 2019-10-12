//
//  DateDecodable.swift
//  TMDB
//
//  Created by Matheus Cardoso Kuhn on 10/10/19.
//  Copyright © 2019 MDT. All rights reserved.
//

import Foundation

struct DateDecodable: Decodable {

    // MARK: - Variables
    let value: Date?

    // MARK: - Life Cycle
    init(value: Date?) {
        self.value = value
    }

    init(from decoder: Decoder) throws {
        self.value = try String(from: decoder).convertToDate(format: "yyyy/MM/dd")
    }
}
