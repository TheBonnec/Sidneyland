//
//  ModificateursPageDetailSection.swift
//  Sidneyland
//
//  Created by Thomas Le Bonnec on 07/10/2025.
//

import SwiftUI

extension EnvironmentValues {
    @Entry var pageDetailSectionAvecFavoris: Bool = true
    @Entry var imagePageDetailSection: String = "Chateau"
}


extension View {
    func pageDetailSectionAvecFavoris(_ valeur: Bool) -> some View {
        return self
            .environment(\.pageDetailSectionAvecFavoris, valeur)
    }
    
    func imagePageDetailSection(_ valeur: String) -> some View {
        self
            .environment(\.imagePageDetailSection, valeur)
    }
}
