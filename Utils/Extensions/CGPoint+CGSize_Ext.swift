//
//  File.swift
//  
//
//  Created by Home on 04/08/24.
//

import Foundation

protocol Dimension2D {
    var a:CGFloat {get set}
    var b:CGFloat {get set}
    
    init()
}

extension Dimension2D {
    fileprivate init(a: CGFloat, b: CGFloat) {
        self.init()
        self.a = a
        self.b = b
    }
    
    init(_ c: CGFloat) { 
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
    
    func `as`<T: Dimension2D>(_ newType: T.Type) -> T {
        newType.init(a: a, b: b)
    }
    
    mutating func invert() {
        (a,b) = (b,a)
    }
}


extension CGPoint: Dimension2D {
    public var a: CGFloat {
        get { x }
        set { x = newValue }
    }
    
    public var b: CGFloat {
        get { y }
        set { y = newValue }
    }
}


extension CGSize: Dimension2D {
    public var a: CGFloat {
        get { width }
        set { width = newValue }
    }
    
    public var b: CGFloat {
        get { height }
        set { height = newValue }
    }
}
