//
//  Array.swift
//  Utils
//
//  Created by Home on 06/09/25.
//

import Foundation

extension Array {
     func first<T>(mapping: (Element)->T?) -> T? {
         for element in self {
             if let mappedValue = mapping(element) {
                 return mappedValue
             }
         }
         return nil
     }

     func group<Success, Failure>() -> ([Success], [Failure]) where Element == Result<Success, Failure> {
        var success: [Success] = []
        var failures: [Failure] = []
        self.forEach {
            switch $0 {
            case .success(let value): success.append(value)
            case .failure(let error): failures.append(error)
            }
        }
        return (success, failures)
    }
}
