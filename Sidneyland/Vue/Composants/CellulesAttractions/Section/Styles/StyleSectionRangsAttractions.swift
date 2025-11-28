//
//  StyleSectionRangsAttractions.swift
//  Sidneyland
//
//  Created by Thomas Le Bonnec on 07/10/2025.
//

import SwiftUI


struct StyleSectionRangsAttractions: StyleSectionAttractions {
    
    func créerCorps(configuration: ConfigurationSectionAttractions) -> some View {
        SectionRangsAttractions(configuration: configuration)
    }
    
    
    
    fileprivate struct SectionRangsAttractions: View {
        
        // MARK: Attributs
        
        @Environment(\.nbRangsSectionAttractions) var nbRangs
        @Environment(\.afficherTitreSectionAttractions) var afficherTitre
        @Environment(\.sectionAttractionsMonopage) var monopage
        @Environment(\.pageDetailSectionAvecFavoris) var avecFavoris
        
        let configuration: ConfigurationSectionAttractions
        
        private let rangs = Array(
            repeating: GridItem(spacing: 16, alignment: .top),
            count: 6
        )
        
        
        
        // MARK: Vue
        
        var body: some View {
            VStack(spacing: 16) {
                if let titre = configuration.titre, let symbole = configuration.symbole, afficherTitre {
                    NavigationLink {
                        PageDetailSection(namespace: configuration.namespace, titre: titre, attractions: configuration.attractions)
                            .pageDetailSectionAvecFavoris(avecFavoris)
                    } label: {
                        TitreSectionAttractions(symbole: symbole, titre: titre)
                    }
                }
                
                vueRangs
            }
        }
        
        
        var vueRangs: some View {
            ScrollView(.horizontal) {
                LazyHGrid(rows: Array(rangs[0..<(nbRangs * 3)]), alignment: .center, spacing: 16) {
                    ForEach(configuration.attractions, id: \.id) { attraction in
                        RangAttraction(namespace: configuration.namespace, attraction: attraction)
                    }
                    .padding(.horizontal, 16)
                    .containerRelativeFrame(.horizontal, count: 1, spacing: 0, alignment: .center)
                }
                .scrollTargetLayout()
            }
            .scrollTargetBehavior(.viewAligned)
            .scrollIndicators(.hidden)
            .scrollClipDisabled()
        }
        
        
        var vueMonopage: some View {
            LazyVStack(spacing: 16) {
                ForEach(configuration.attractions, id: \.id) { attraction in
                    RangAttraction(namespace: configuration.namespace, attraction: attraction)
                }
            }
        }
    }
}
