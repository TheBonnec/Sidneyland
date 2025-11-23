//
//  StyleSectionCartesAttractions.swift
//  Sidneyland
//
//  Created by Thomas Le Bonnec on 06/10/2025.
//

import SwiftUI


struct StyleSectionCartesAttractions: StyleSectionAttractions {
    
    func créerCorps(configuration: ConfigurationSectionAttractions) -> some View {
        SectionCartesAttractions(configuration: configuration)
    }
    
    
    
    fileprivate struct SectionCartesAttractions: View {
        
        // MARK: Attributs
        
        @Environment(\.nbRangsSectionAttractions) var nbRangs
        @Environment(\.conteneuriserSectionAttractions) var conteneuriser
        @Environment(\.afficherTitreSectionAttractions) var afficherTitre
        @Environment(\.pageDetailSectionAvecFavoris) var avecFavoris
        
        let configuration: ConfigurationSectionAttractions
        
        private let rangs = Array(
            repeating: GridItem(.adaptive(minimum: 180, maximum: 300), spacing: 20, alignment: .top),
            count: 2
        )
        
        
        
        // MARK: Vue
        
        var body: some View {
            VStack(spacing: 16 + 4.25) { // largeur qui dépasse du coeur
                /*if let titre = configuration.titre, let symbole = configuration.symbole, afficherTitre {
                    NavigationLink {
                        PageDetailSection(namespace: configuration.namespace, titre: titre, attractions: configuration.attractions)
                            .pageDetailSectionAvecFavoris(avecFavoris)
                    } label: {
                        TitreSectionAttractions(symbole: symbole, titre: titre, conteneuriser: conteneuriser)
                    }
                }*/
                
                vueCartes
                    .styleConteneurisé(conteneuriser)
            }
        }
        
        
        var vueCartes: some View {
            ScrollView(.horizontal) {
                LazyHGrid(rows: Array(rangs[0..<nbRangs]), alignment: .top, spacing: 20) {
                    ForEach(configuration.attractions, id: \.id) { attraction in
                        CarteAttraction(namespace: configuration.namespace, attraction: attraction)
                    }
                }
                .scrollTargetLayout()
                .padding(.horizontal, conteneuriser ? 12 : 16)
                .fixedSize(horizontal: false, vertical: true)
            }
            .scrollTargetBehavior(.viewAligned)
            .scrollIndicators(.hidden)
            .scrollClipDisabled()
        }
    }
}





fileprivate extension View {
    func styleConteneurisé(_ condition: Bool) -> some View {
        Group {
            if condition {
                self
                    .padding(.vertical, 12)
                    .background(Color.white.opacity(0.16))
                    .bordureArrondie(rayon: 24 + 12)
                    .clipped()
                    .padding(.horizontal, 8)
            } else {
                self
            }
        }
    }
}
