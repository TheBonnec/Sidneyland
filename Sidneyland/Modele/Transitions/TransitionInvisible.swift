//
//  TransitionInvisible.swift
//  Sidneyland
//
//  Created by Thomas Le Bonnec on 28/11/2024.
//

import SwiftUI

extension AnyTransition {
    static var invisible: AnyTransition {
        AnyTransition.modifier(
            active: ModificateurInvisible(progression: 0),
            identity: ModificateurInvisible(progression: 1)
        )
    }
    
    struct ModificateurInvisible: AnimatableModifier {
        var progression: Double
        
        var donnéesAnimables: Double {
            get { progression }
            set { progression = newValue }
        }
        
        
        func body(content: Content) -> some View {
            content.opacity(progression == 1.0 ? 1 : 0)
        }
    }
}
