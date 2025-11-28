//
//  View+Extensions.swift
//  Sidneyland
//
//  Created by Thomas Le Bonnec on 30/09/2025.
//

import SwiftUI


extension View {
    @ViewBuilder
    func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
    
    
    @ViewBuilder
    func `if`<Content: View, ElseContent: View>(_ condition: Bool, transform: (Self) -> Content, elseTransform: (Self) -> ElseContent) -> some View {
        if condition {
            transform(self)
        } else {
            elseTransform(self)
        }
    }
}
