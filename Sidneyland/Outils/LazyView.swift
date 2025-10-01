//
//  LazyView.swift
//  Sidneyland
//
//  Created by Thomas Le Bonnec on 28/11/2024.
//

import SwiftUI

/// Permet de créer la vue contenue seulement au moment où elle est affichée
/// Utile pour ne pas charger le contenu des NavigationLink au démarrage de l'app
struct LazyView<Content: View>: View {
    let build: () -> Content

    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }

    var body: Content {
        build()
    }
}
