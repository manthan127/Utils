//
//  extentions.swift
//  chess
//
//  Created by mac on 21/11/22.
//

import SwiftUI

extension View {
    func geometry(_ completion: @escaping (CGSize)->()) -> some View {
        self.background (
            GeometryReader { proxy in
                Color.clear
                    .onAppear {
                        completion(proxy.size)
                    }
                    .onChange(of: proxy.size) { _ in
                        completion(proxy.size)
                    }
            }
        )
    }
}

extension View {
    
    @ViewBuilder
    func quickModifier<V: View>(@ViewBuilder _ view: (Self)->V) -> some View {
        view(self)
    }
    
    @ViewBuilder
    func `if`<V: View>(_ condition: Bool, @ViewBuilder _ view: (Self)->V)-> some View {
        if condition {
            view(self)
        }
    }
    
    @ViewBuilder
    func `if`<A, V: View>(`let` optinal: Optional<A>, @ViewBuilder _ view: (Self, A)->V)-> some View {
        if let optinal {
            view(self, optinal)
        }
    }
    
    @ViewBuilder
    func `if`<V: View, V1: View>(_ condition: Bool, @ViewBuilder _ view: (Self)->V, @ViewBuilder `else`: (Self)->V1)-> some View {
        if condition {
            view(self)
        } else {
            `else`(self)
        }
    }
    
    @ViewBuilder
    func `if`<A, V: View, V1: View>(`let` optinal: Optional<A>, @ViewBuilder _ view: (Self, A)->V, @ViewBuilder `else`: (Self)->V1)-> some View {
        if let optinal {
            view(self, optinal)
        }
        else {
            `else`(self)
        }
    }
}


@available(iOS 16.0, *)
extension View {
    func asHighQualityUIImage(size: CGSize, scale: CGFloat? = nil) async -> UIImage? {
        await MainActor.run {
            let renderer = ImageRenderer(content: self)
            renderer.scale = scale ?? UIScreen.main.scale
            renderer.proposedSize = .init(size)
            return renderer.uiImage
        }
    }
}
