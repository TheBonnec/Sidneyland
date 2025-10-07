//
//  SelectionOnglet.swift
//  Sidneyland
//
//  Created by Thomas Le Bonnec on 28/11/2024.
//

import SwiftUI

class SelectionOnglet: ObservableObject {
    @Published var sélection: Int = 0
}



enum Onglet {
    case pagePrincipale, carte
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
