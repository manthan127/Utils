//
//  Optional.swift
//  Utils
//
//  Created by Home on 06/04/25.
//

import Foundation

extension Optional {
    func unwrap(orThrow error: Error) throws -> Wrapped {
        if let self { return self }
        throw error
    }
}

extension Optional where Wrapped == String {
    var nonEmptyTrimmed: String? {
        if let self {
            if self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                nil
            } else {
                self
            }
        } else {
            nil
        }
    }
}

infix operator ???
extension Optional {
    static func ???(_ lhs: Wrapped?, _ rhs: Error) throws -> Wrapped {
        if let lhs {
            return lhs
        }
        
        throw rhs
    }
}
