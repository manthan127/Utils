//
//  TypedErrorHandler.swift
//  Utils
//
//  Created by Home on 10/05/25.
//

import Foundation

protocol AnyErrorHandler {
    associatedtype E: Error
    
    func handle(_ error: Error) -> Bool
}

struct TypedErrorHandler<E: Error>: AnyErrorHandler {
    let type: E.Type
    let closure: (E) -> Void
    init(type: E.Type, _ closure: @escaping (E) -> Void) {
        self.type = type
        self.closure = closure
    }

    func handle(_ error: Error) -> Bool {
        guard let specific = error as? E else { return false }
        closure(specific)
        return true
    }
}
