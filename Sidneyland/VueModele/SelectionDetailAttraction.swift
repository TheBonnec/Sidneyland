//
//  SelectionDetailAttraction.swift
//  Sidneyland
//
//  Created by Thomas Le Bonnec on 27/11/2025.
//

import SwiftUI

extension EnvironmentValues {
    @Entry var ouvrirDétailAttraction: (Attraction?) -> Void = { _ in }
}


extension View {
    func actionOuvrirDétailAttraction(_ action: @escaping (Attraction?) -> Void) -> some View {
        self
            .environment(\.ouvrirDétailAttraction, action)
    }
}
