//
//  File.swift
//  
//
//  Created by Home on 13/05/26.
//

import Foundation

protocol RangeProtocol {
    associatedtype Bound: Comparable
    var lowerBound: Bound {get}
    var upperBound: Bound {get}
}

extension ClosedRange: RangeProtocol {}
extension Range: RangeProtocol {}

extension Comparable {
    mutating func clamp<R: RangeProtocol>(inside range: R) where R.Bound == Self {
        self = self.clamped(inside: range)
    }
    
    func clamped<R: RangeProtocol>(inside range: R) -> Self where R.Bound == Self {
        max(min(self, range.upperBound), range.lowerBound)
    }
}
