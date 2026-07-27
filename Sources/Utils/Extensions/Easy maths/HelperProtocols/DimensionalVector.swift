//
//  File.swift
//  
//
//  Created by Home on 04/08/24.
//

import Foundation

protocol ArithmeticOperator {
    static func +(_ lhs: Self, _ rhs: Self)-> Self
    static func -(_ lhs: Self, _ rhs: Self)-> Self
    static func *(_ lhs: Self, _ rhs: Self)-> Self
    static func /(_ lhs: Self, _ rhs: Self)-> Self
}

extension Int: ArithmeticOperator {}
extension Float: ArithmeticOperator {}
extension Double: ArithmeticOperator {}
extension CGFloat: ArithmeticOperator {}

protocol DimensionalVector {
    associatedtype V: ArithmeticOperator
    var arr: [V] {get set}
    static var elementsCount: Int { get }
    
    init()
}

extension DimensionalVector {
    fileprivate init(arr: [V]) {
        self.init()
        self.arr = arr
    }
    
    static func +(_ lhs: Self, _ rhs: Self)-> Self {
        Self(arr: zip(lhs.arr, rhs.arr).map {$0 + $1})
    }
    static func -(_ lhs: Self, _ rhs: Self)-> Self {
        Self(arr: zip(lhs.arr, rhs.arr).map {$0 - $1})
    }
    static func *(_ lhs: Self, _ rhs: Self)-> Self {
        Self(arr: zip(lhs.arr, rhs.arr).map {$0 * $1})
    }
    static func /(_ lhs: Self, _ rhs: Self)-> Self {
        Self(arr: zip(lhs.arr, rhs.arr).map {$0 / $1})
    }
    
    static func +=(_ lhs: inout Self, _ rhs: Self) {
        lhs = lhs+rhs
    }
    static func -=(_ lhs: inout Self, _ rhs: Self) {
        lhs = lhs-rhs
    }
    static func *=(_ lhs: inout Self, _ rhs: Self) {
        lhs = lhs*rhs
    }
    static func /=(_ lhs: inout Self, _ rhs: Self) {
        lhs = lhs/rhs
    }
}

extension DimensionalVector {
    init(_ c: V) {
        self.init(arr: Array(repeating: c, count: Self.elementsCount))
    }
    
    static func +(_ lhs: Self, _ rhs: V)-> Self {
        lhs + Self.init(rhs)
    }
    static func -(_ lhs: Self, _ rhs: V)-> Self {
        lhs - Self.init(rhs)
    }
    static func *(_ lhs: Self, _ rhs: V)-> Self {
        lhs * Self.init(rhs)
    }
    static func /(_ lhs: Self, _ rhs: V)-> Self {
        lhs / Self.init(rhs)
    }
    
    static func +=(_ lhs: inout Self, _ rhs: V)  {
        lhs = lhs+rhs
    }
    static func -=(_ lhs: inout Self, _ rhs: V)  {
        lhs = lhs-rhs
    }
    static func *=(_ lhs: inout Self, _ rhs: V)  {
        lhs = lhs*rhs
    }
    static func /=(_ lhs: inout Self, _ rhs: V)  {
        lhs = lhs/rhs
    }
}
