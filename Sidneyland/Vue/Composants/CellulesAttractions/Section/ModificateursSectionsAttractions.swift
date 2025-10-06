//
//  ModificateursSectionsAttractions.swift
//  Sidneyland
//
//  Created by Thomas Le Bonnec on 06/10/2025.
//

import SwiftUI


extension EnvironmentValues {
    @Entry var nbRangsSectionAttractions: Int = 1
    @Entry var conteneuriserSectionAttractions: Bool = false
    @Entry var afficherTitreSectionAttractions: Bool = true
    @Entry var sectionAttractionsMonopage: Bool = false
}



extension View {
    func nbRangsSectionAttractions(_ valeur: Int) -> some View {
        self
            .environment(\.nbRangsSectionAttractions, max(min(valeur, 2), 1))
    }
    
    func conteneuriserSectionAttractions(_ valeur: Bool) -> some View {
        self
            .environment(\.conteneuriserSectionAttractions, valeur)
    }
    
    func afficherTitreSectionAttractions(_ valeur: Bool) -> some View {
        self
            .environment(\.afficherTitreSectionAttractions, valeur)
    }
    
    func sectionAttractionsMonopage(_ valeur: Bool) -> some View {
        self
            .environment(\.sectionAttractionsMonopage, valeur)
    }
}
