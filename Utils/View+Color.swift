//
//  extentions.swift
//  chess
//
//  Created by mac on 21/11/22.
//

import SwiftUI

extension View {
    func geometry(_ completion: @escaping (GeometryProxy)->()) -> some View {
        self.background (
            GeometryReader { geo in
                Color.clear
                    .onAppear {
                        completion(geo)
                    }
            }
        )
    }
}

extension Color {
    
    static var random: Color {
        Color(hue: .random(in: 0...1), saturation: 1, brightness: 1)
    }
    
    init(hex: String) {
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        
        let a, r, g, b: UInt64
        switch hex.count {
        case 6:
            (r, g, b, a) = (int >> 16, int >> 8 & 0xFF, int & 0xFF, 255)
        case 8:
            (r, g, b, a) = (int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF, int >> 24)
        default:
            self = .clear; return
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
    
    func toHex() -> String {
        guard let components = cgColor?.components else { return "000000" }

        let r = components[0]
        let g = components[1]
        let b = components[2]
        let a = components[3]

        return String(format: "%02lX%02lX%02lX%02lX", int(a), int(r), int(g), int(b))
    }
    
    private func int(_ f: CGFloat)-> Int {
        lroundf(Float(f*255))
    }
}
