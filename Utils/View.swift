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

#Preview {
    Temp()
}

struct Temp: View {
    @State var Mul: CGFloat = 1
    
    var body: some View {
        HStack(spacing: -20) {
            Capsule()
                .fill(.red)
                .rotationEffect(Angle(degrees: -15 * Mul), anchor: .trailing)
            Capsule()
                .fill(.green)
                .rotationEffect(Angle(degrees: 15 * Mul), anchor: .leading)
                
        }
        .compositingGroup()
        .frame(width: 400, height: 20)
        .opacity(0.5)
        .onTapGesture {
            withAnimation(.linear(duration: 1)) {
                Mul *= -1
            }
        }
    }
}
