//
//  AdaptiveSheetHeightModifier.swift
//  Towing Customer
//
//  Created by macm4 on 04/04/25.
//

import SwiftUI

struct AdaptiveSheetHeightModifier: ViewModifier {
    @State private var height: CGFloat = 0
    var detents: Set<PresentationDetent> = []
    
    func body(content: Content) -> some View {
        content
            .geometry {
                height = $0.height
            }
            .presentationDetents(detents.union([.height(height)]))
    }
}

extension View {
    public func adaptiveSheetHeight(detents: Set<PresentationDetent> = []) -> some View {
        modifier(AdaptiveSheetHeightModifier(detents: detents))
    }
}
