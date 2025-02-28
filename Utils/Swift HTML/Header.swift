//
//  Header.swift
//  Utils
//
//  Created by Home on 28/02/25.
//

import Foundation

struct h1: HTML {
    @HTMLBuilder var content: ()-> [any HTML]
    
    func render() -> String {
        let html = content().map { $0.render() }.joined(separator: "\n")
        return "<h1>\(html)</h1>"
    }
}

struct h2: HTML {
    @HTMLBuilder var content: ()-> [any HTML]
    
    func render() -> String {
        let html = content().map { $0.render() }.joined(separator: "\n")
        return "<h2>\(html)</h2>"
    }
}

struct h3: HTML {
    @HTMLBuilder var content: ()-> [any HTML]
    
    func render() -> String {
        let html = content().map { $0.render() }.joined(separator: "\n")
        return "<h3>\(html)</h3>"
    }
}

struct h4: HTML {
    @HTMLBuilder var content: ()-> [any HTML]
    
    func render() -> String {
        let html = content().map { $0.render() }.joined(separator: "\n")
        return "<h4>\(html)</h4>"
    }
}

struct h5: HTML {
    @HTMLBuilder var content: ()-> [any HTML]
    
    func render() -> String {
        let html = content().map { $0.render() }.joined(separator: "\n")
        return "<h5>\(html)</h5>"
    }
}
