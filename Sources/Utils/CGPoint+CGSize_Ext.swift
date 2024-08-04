//
//  File.swift
//  
//
//  Created by Home on 04/08/24.
//

import Foundation

public
protocol ABC {
    var a:CGFloat {get set}
    var b:CGFloat {get set}
    
    init(a: CGFloat, b: CGFloat)
}

public
extension ABC {
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
    
    static func +(_ lhs: Self, _ rhs: CGFloat)-> Self {
        Self(a: lhs.a + rhs, b: lhs.b + rhs)
    }
    static func -(_ lhs: Self, _ rhs: CGFloat)-> Self {
        Self(a: lhs.a - rhs, b: lhs.b - rhs)
    }
    static func *(_ lhs: Self, _ rhs: CGFloat)-> Self {
        Self(a: lhs.a * rhs, b: lhs.b * rhs)
    }
    static func /(_ lhs: Self, _ rhs: CGFloat)-> Self {
        Self(a: lhs.a / rhs, b: lhs.b / rhs)
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
    
    static func +=(_ lhs: inout Self, _ rhs: CGFloat) {
        lhs = lhs+rhs
    }
    static func -=(_ lhs: inout Self, _ rhs: CGFloat) {
        lhs = lhs-rhs
    }
    static func *=(_ lhs: inout Self, _ rhs: CGFloat) {
        lhs = lhs*rhs
    }
    static func /=(_ lhs: inout Self, _ rhs: CGFloat) {
        lhs = lhs/rhs
    }
    
    func convert<T: ABC>(to newType: T.Type) -> T {
        newType.init(a: a, b: b)
    }
    
    mutating func invert() {
        (a,b) = (b,a)
    }
}


extension CGPoint: ABC {
    public init(a: CGFloat, b: CGFloat) {
        self.init(x: a, y: b)
    }
    
    public var a: CGFloat {
        get { x }
        set { x = newValue }
    }
    
    public var b: CGFloat {
        get { y }
        set { y = newValue }
    }
}


extension CGSize: ABC {
    public init(a: CGFloat, b: CGFloat) {
        self.init(width: a, height: b)
    }
    
    public var a: CGFloat {
        get { width }
        set { width = newValue }
    }
    
    public var b: CGFloat {
        get { height }
        set { height = newValue }
    }
}
