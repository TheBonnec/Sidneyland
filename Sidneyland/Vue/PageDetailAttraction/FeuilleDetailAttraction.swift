//
//  FeuilleDetailAttraction.swift
//  Sidneyland
//
//  Created by Thomas Le Bonnec on 30/09/2025.
//

import SwiftUI

struct FeuilleDetailAttraction: View {
    
    // MARK: Attributs
    
    var attraction: Attraction
    
    
    
    // MARK: Vue
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
    
    
    var vueAttent: some View {
        VStack {
            if let informations = attraction.informations, informations.fonctionnement == .enMarche {
                Text("\(informations.tempsAttente)")
            }
        }
    }
}





#Preview {
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
    
    return FeuilleDetailAttraction(attraction: attraction)
}
