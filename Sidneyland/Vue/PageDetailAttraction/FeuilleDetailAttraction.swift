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
    
    @State var informations: InformationsAttraction? = nil
    
    
    
    // MARK: Vue
    
    var body: some View {
        HStack(spacing: 16) {
            vueAttente
            if informations?.tempsSingleRider != nil {
                vueSingleRider
            }
            if informations?.horaireFermeture != nil {
                vueHoraireFermeture
            }
        }
        .multilineTextAlignment(.center)
        .fixedSize(horizontal: false, vertical: true)
        .padding()
        .onAppear {
            informations = attraction.informations
        }
    }
    
    
    var vueAttente: some View {
        VStack(spacing: 16) {
            Text("Temps d'attente")
                .font(.description)
            
            VStack {
                if let informations = informations, informations.fonctionnement == .enMarche {
                    Text("\(informations.tempsAttente)")
                        .font(.informationImportante)
                    
                    Text("min")
                        .font(.sousTitre)
                } else {
                    let fonctionnement = informations?.fonctionnement ?? .inconnu
                    
                    Image(systemName: fonctionnement.image)
                        .font(.informationImportante)
                        .padding(.bottom, 4)
                    
                    Text(fonctionnement.description)
                        .font(.sousTitre)
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background {
            Rectangle()
                .fill(.ultraThinMaterial)
        }
        .bordureArrondie(rayon: 24)
    }
    
    
    var vueSingleRider: some View {
        VStack(spacing: 16) {
            Text("Single Rider")
                .font(.description)
            
            VStack {
                Text("\(informations?.tempsSingleRider ?? 0)")
                    .font(.informationImportante)
                
                Text("min")
                    .font(.sousTitre)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            Rectangle()
                .fill(.ultraThinMaterial)
        }
        .bordureArrondie(rayon: 24)
    }
    
    
    var vueHoraireFermeture: some View {
        VStack(spacing: 16) {
            Text("Horaire de fermeture")
                .font(.description)
            
            Text(informations?.horaireFermeture?.enHoraire() ?? "?")
                .font(.informationImportante)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            Rectangle()
                .fill(.ultraThinMaterial)
        }
        .bordureArrondie(rayon: 24)
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
        fonctionnement: .enPanne
    ))
    
    return FeuilleDetailAttraction(attraction: attraction)
}
