//
//  SectionAttractions.swift
//  Sidneyland
//
//  Created by Thomas Le Bonnec on 29/09/2025.
//

import SwiftUI

struct SectionAttractions: View {
    
    // MARK: Attributs
    
    var namespace: Namespace.ID
    var symbole: String?
    var titre: String
    var conteneurisé: Bool
    var attractions: [Attraction]
    var nbRangs: Int
    
    private let rangs = [
        GridItem(.adaptive(minimum: 180, maximum: 300), spacing: 20, alignment: .top),
        GridItem(.adaptive(minimum: 180, maximum: 300), spacing: 20, alignment: .top),
        GridItem(.adaptive(minimum: 180, maximum: 300), spacing: 20, alignment: .top),
        GridItem(.adaptive(minimum: 180, maximum: 300), spacing: 20, alignment: .top),
        GridItem(.adaptive(minimum: 180, maximum: 300), spacing: 20, alignment: .top)
    ]
    
    
    
    // MARK: Init
    
    init(namespace: Namespace.ID, symbole: String? = nil, titre: String, conteneurisé: Bool = false, attractions: [Attraction], nbRangs: Int? = nil) {
        self.namespace = namespace
        self.symbole = symbole
        self.titre = titre
        self.conteneurisé = conteneurisé
        self.attractions = attractions
        
        if let nbRangs, nbRangs > 0 {
            if nbRangs <= 5 {
                self.nbRangs = nbRangs
            } else {
                self.nbRangs = 5
            }
        } else {
            self.nbRangs = 1
        }
    }
    
    
    
    // MARK: Vue
    
    var body: some View {
        VStack(spacing: 16 + 4.25) { // largeur qui dépasse du coeur
            vueTitre
            vueAttractions
        }
        .styleConteneurisé(conteneurisé)
    }
    
    
    var vueTitre: some View {
        HStack(spacing: 8) {
            if let symbole {
                Image(systemName: symbole)
                    .font(.sousTitre)
            }
            
            Text(titre)
                .font(.titreSection)
                .padding(.trailing, 6)
            
            Image(systemName: "chevron.right")
                .font(.sousTitre)
            
            Spacer()
        }
        .padding(.leading)
        .if(conteneurisé) { vue in
            vue.padding(.leading, 2)
        }
        .foregroundStyle(Color.white)
    }
    
    
    var vueAttractions: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: Array(rangs[0..<nbRangs]), alignment: .top, spacing: 20) {
                ForEach(attractions, id: \.id) { attraction in
                    CarteAttraction(namespace: namespace, attraction: attraction)
                }
            }
            .scrollTargetLayout()
            .padding(.horizontal, conteneurisé ? 8 : 16)
            .fixedSize(horizontal: false, vertical: true)
        }
        .scrollTargetBehavior(.viewAligned)
        .scrollIndicators(.hidden)
        .scrollClipDisabled()
    }
}




fileprivate extension View {
    func styleConteneurisé(_ condition: Bool) -> some View {
        Group {
            if condition {
                self
                    .padding(.vertical, 8)
                    .padding(.top, 12)
                    .background(Color.white.opacity(0.16))
                    .bordureArrondie(rayon: 24 + 8)
                    .clipped()
                    .padding(.horizontal, 8)
            } else {
                self
            }
        }
    }
}





#Preview {
    @Previewable @Namespace var namespace
    
    let attractions = RegistreAttractions.attractions().filter { $0.univers == .frontierland }
    
    for i in 0...attractions.count - 1 {
        attractions[i].modifierInformation(InformationsAttraction(
            tempsAttente: 5 * (i + 1),
            tempsSingleRider: nil,
            horaireFermeture: Date(),
            fonctionnement: i == 2 ? .fermée : .enMarche
        ))
    }
    
    return FondPrincipal(image: "Chateau") {
        VStack(spacing: 32) {
            SectionAttractions(namespace: namespace, symbole: "heart.fill", titre: "Frontierland", attractions: attractions)
            
            SectionAttractions(namespace: namespace, symbole: "heart.fill", titre: "Frontierland", conteneurisé: true, attractions: attractions)
        }
    }
}
