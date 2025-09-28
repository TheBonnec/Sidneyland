//
//  TransitionModale.swift
//  Sidneyland
//
//  Created by Thomas Le Bonnec on 28/11/2024.
//

import SwiftUI

extension AnyTransition {
    static var modale: AnyTransition {
        AnyTransition.modifier(
            active: ModificateurVignette(progression: 0),
            identity: ModificateurVignette(progression: 1)
        )
    }
    
    struct ModificateurVignette: AnimatableModifier {
        var progression: CGFloat
        
        var donnéesAnimables: CGFloat {
            get { progression }
            set { progression = newValue }
        }
        
        func body(content: Content) -> some View {
            return content
                .environment(\.progressionTransitionModale, progression)
                .opacity(1)
        }
    }
}
