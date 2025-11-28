//
//  SectionAttractions.swift
//  Sidneyland
//
//  Created by Thomas Le Bonnec on 29/09/2025.
//

import SwiftUI

struct SectionAttractions<Style: StyleSectionAttractions>: View {
    
    // MARK: Attributs
    
    var config: ConfigurationSectionAttractions
    var style: Style
    
    
    
    // MARK: Init
    
    init(style: Style, namespace: Namespace.ID, symbole: String? = nil, titre: String? = nil, attractions: [Attraction]) {
        self.config = .init(namespace: namespace, symbole: symbole, titre: titre, attractions: attractions)
        self.style = style
    }
    
    
    init(config: ConfigurationSectionAttractions, style: Style) {
        self.config = config
        self.style = style
    }
    
    
    
    // MARK: Vue
    
    var body: some View {
        style.créerCorps(configuration: config)
    }
}



extension SectionAttractions where Style == StyleSectionCartesAttractions {
    init(namespace: Namespace.ID, symbole: String? = nil, titre: String? = nil, attractions: [Attraction]) {
        self.init(style: StyleSectionCartesAttractions(), namespace: namespace, symbole: symbole, titre: titre, attractions: attractions)
    }
}





#Preview {
    @Previewable @Namespace var namespace
    
    let attractions = RegistreAttractions.attractions().filter { $0.univers == .frontierland }
    
    for i in 0...attractions.count - 1 {
        attractions[i].état = EtatAttraction(
            tempsAttente: 5 * (i + 1),
            tempsSingleRider: nil,
            horaireOuverture: Date(),
            horaireFermeture: Date(),
            fonctionnement: i == 2 ? .fermée : .enMarche
        )
    }
    
    return FondImageFloue(image: "Chateau") {
        ScrollView {
            VStack(spacing: 32) {
                SectionAttractions(namespace: namespace, symbole: "heart.fill", titre: "Frontierland", attractions: attractions)
                    //.style(.rangs)
                
                SectionAttractions(namespace: namespace, symbole: "heart.fill", titre: "Frontierland", attractions: attractions)
            }
        }
    }
}
