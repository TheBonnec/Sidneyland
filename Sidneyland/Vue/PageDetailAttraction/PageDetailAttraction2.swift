//
//  PageDetailAttraction2.swift
//  Sidneyland
//
//  Created by Thomas Le Bonnec on 30/09/2025.
//

import SwiftUI

struct PageDetailAttraction2: View {
    
    // MARK: Attributs
    
    var namespace: Namespace.ID
    var attraction: Attraction
    
    @State private var sélection: PresentationDetent = .height(120)
    
    
    
    // MARK: Vue
    
    var body: some View {
        vueImage
            .sheet(isPresented: .constant(true)) {
                vueFeuille
                    .presentationDetents([.height(120), .medium, .large], selection: $sélection)
                    .presentationDragIndicator(.visible)
                    .presentationBackgroundInteraction(.enabled(upThrough: .medium))
            }
    }
    
    
    var vueImage: some View {
        Image(attraction.image)
            .resizable()
            .scaledToFill()
            .frame(minWidth: 0, maxWidth: .infinity)
            .ignoresSafeArea()
    }
    
    
    var vueFeuille: some View {
        VStack {
            Text(attraction.nom)
                .font(.titreSection)
        }
    }
}





#Preview {
    @Previewable @Namespace var namespace
    
    let attraction = Attraction(
        id: "P0AA00",
        nom: "Big Thunder Mountain",
        image: "BTM",
        parc: .disneyland,
        univers: .frontierland
    )
    
    attraction.estFavorite = true
    
    attraction.modifierInformation(InformationsAttraction(
        tempsAttente: 15,
        tempsSingleRider: nil,
        horaireFermeture: Date(),
        fonctionnement: .enMarche
    ))
    
    return PageDetailAttraction2(namespace: namespace, attraction: attraction)
}
