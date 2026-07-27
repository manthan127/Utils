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
    
//    static func +=(_ lhs: inout Self, _ rhs: Self)
//    static func -=(_ lhs: inout Self, _ rhs: Self)
//    static func *=(_ lhs: inout Self, _ rhs: Self)
//    static func /=(_ lhs: inout Self, _ rhs: Self)
}

extension CGFloat: ArithmeticOperator {}
extension Int: ArithmeticOperator {}
extension Double: ArithmeticOperator {}

protocol Dimension2D {
    associatedtype V: ArithmeticOperator
    var a:V {get set}
    var b:V {get set}
    
    init()
}

extension Dimension2D {
    fileprivate init(a: V, b: V) {
        self.init()
        self.a = a
        self.b = b
    }
    
    init(_ c: V) {
        self.init(a: c, b: c)
    }
    
    static func +(_ lhs: Self, _ rhs: Self)-> Self {
        Self(a: lhs.a + rhs.a, b: lhs.b + rhs.b)
    }
    static func -(_ lhs: Self, _ rhs: Self)-> Self {
        Self(a: lhs.a - rhs.a, b: lhs.b - rhs.b)
    }
    static func *(_ lhs: Self, _ rhs: Self)-> Self {
        Self(a: lhs.a * rhs.a, b: lhs.b * rhs.b)
    }
    static func /(_ lhs: Self, _ rhs: Self)-> Self {
        Self(a: lhs.a / rhs.a, b: lhs.b / rhs.b)
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
    
    func `as`<T: Dimension2D>(_ newType: T.Type) -> T where T.V == V {
        newType.init(a: a, b: b)
    }
    
    mutating func invert() {
        (a,b) = (b,a)
    }
}

extension Dimension2D {
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

