//
//  ErrorObject.swift
//  TMDB
//
//  Created by Matheus Cardoso kuhn on 26/08/2018.
//  Copyright © 2018 MDT. All rights reserved.
//

import Foundation

class ErrorObject: Error {
    var code: Int?
    var message: String?
    init(code: Int, message: String) {
        self.code = code
        self.message = message
    }
}
