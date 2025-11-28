//
//  SelectionOnglet.swift
//  Sidneyland
//
//  Created by Thomas Le Bonnec on 28/11/2024.
//

import SwiftUI

enum Onglet {
    case pagePrincipale, carte
    
    // Les valeurs sont inversés car se sont celles à afficher pour indiquer la direction
    var titre: String {
        switch self {
        case .pagePrincipale:
            return "Carte"
        case .carte:
            return "Attractions"
        }
    }
    
    var icone: String {
        switch self {
        case .pagePrincipale:
            return "map.fill"
        case .carte:
            return "rectangle.fill.on.rectangle.angled.fill"
        }
    }
}


extension EnvironmentValues {
    @Entry var changerOnglet: (Onglet) -> Void = { _ in }
}


extension View {
    func actionChangerOnglet(_ action: @escaping (Onglet) -> Void) -> some View {
        self
            .environment(\.changerOnglet, action)
    }
}
