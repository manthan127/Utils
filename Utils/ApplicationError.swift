//
//  ApplicationError.swift
//  ReduceProjectSize
//
//  Created by Home on 22/02/25.
//

import Foundation

struct ApplicationError: Swift.Error {
    var meassage: String
    
    init(_ meassage: String) {
        self.meassage = meassage
    }
}
