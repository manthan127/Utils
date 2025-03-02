//
//  HTMLBuilder.swift
//  Utils
//
//  Created by Home on 02/03/25.
//

import Foundation

@resultBuilder
struct HTMLBuilder{
    static func buildOptional(_ components: [any HTML]?) -> [any HTML] {
        components ?? []
    }
    
    static func buildEither(first component: [any HTML]) -> [any HTML] {
        component
    }
    
    static func buildEither(second component: [any HTML]) -> [any HTML] {
        component
    }
    
    static func buildBlock(_ components: [any HTML]...) -> [any HTML] {
        components.flatMap{$0}
    }
    
    static func buildExpression(_ components: any HTML)-> [any HTML] {
        [components]
    }
}
