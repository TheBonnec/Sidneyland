//
//  RangAttraction2.swift
//  Sidneyland
//
//  Created by Thomas Le Bonnec on 05/10/2025.
//

import SwiftUI

struct RangAttraction2: View {
    
    // MARK: Attributs
    
    var namespace: Namespace.ID
    var attraction: Attraction
    
    @State var afficherDétail = false
    
    
    
    // MARK: Vue
    
    var body: some View {
        HStack(spacing: 16) {
            vueImage
            
            
            HStack(spacing: 12) {
                Text(attraction.nomCourt ?? attraction.nom)
                    .font(.corpsImportant)
                    //.frame(width: 100)
                    .lineLimit(2)
                    .truncationMode(.tail)
                    .allowsTightening(true)
                
                if attraction.estFavorite {
                    Image(systemName: "heart.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 15)
                }
            }
            .foregroundStyle(Color.white)
            
            Spacer()
            
            if let informations = attraction.informations {
                IndicateurAttente(tempsAttente: informations.tempsAttente, fonctionnement: informations.fonctionnement)
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            afficherDétail = true
        }
        .sheet(isPresented: $afficherDétail) {
            PageDetailAttraction2(namespace: namespace, attraction: attraction)
                .presentationDragIndicator(.visible)
        }
    }
    
    
    var vueImage: some View {
        Color.clear
            .overlay {
                Image("\(attraction.image) Petit")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    //.frame(width: 60, height: 60)
            }
            .bordureArrondie(rayon: 16)
            .frame(width: 64, height: 64)
    }
}





#Preview {
    @Previewable @Namespace var animationRangAttraction
    
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
    
    return FondImageFloue {
        RangAttraction2(namespace: animationRangAttraction, attraction: attraction)
    }
}
