//
//  Swift HTML.swift
//  Utils
//
//  Created by Home on 28/02/25.
//

import Foundation

protocol HTML {
    func render()-> String
}

extension String: HTML {
    func render()-> String {
        self
    }
}

struct br: HTML {
    func render() -> String {
        "<br />"
    }
}

struct title: HTML {
    private var text: String
    
    init(_ text: String) {
        self.text = text
    }
    
    func render()-> String {
        "<title>\(text)</title>"
    }
}

struct a {
    @HTMLBuilder var content: ()-> [any HTML]
    var href: String? = nil
    
    func render() -> String {
        let html = content().map { $0.render() }.joined(separator: "\n")
        var c = ""
        if let href {
            c = "href=\"\(href)\""
        }
        return "<a \(c)>\(html)</a>"
    }
    
    func href(_ href: String)-> a {
        var copy = self
        copy.href = href
        return copy
    }
}

struct div {
    @HTMLBuilder var content: ()-> [any HTML]
    var classes: [String]? = nil
    
    func render() -> String {
        let html = content().map { $0.render() }.joined(separator: "\n")
        var c = ""
        if let classes = classes?.map({"\"\($0)\""}).joined(separator: " "){
            c = "class=\"\(classes)\""
        }
        return "<div \(c)>\(html)</div>"
    }
}

struct span {
    @HTMLBuilder var content: ()-> [any HTML]
    
    func render() -> String {
        let html = content().map { $0.render() }.joined(separator: "\n")
        
        return "<span>\(html)</span>"
    }
}

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
    
    static func buildExpression(_ compo: any HTML)-> [any HTML] {
        [compo]
    }
}
