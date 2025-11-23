//
//  PageDetailAttraction2.swift
//  Sidneyland
//
//  Created by Thomas Le Bonnec on 30/09/2025.
//

import SwiftUI
import Charts


struct PageDetailAttraction2: View {
    
    // MARK: Attributs
    
    var namespace: Namespace.ID
    var attraction: Attraction
    
    let rangs = [
        GridItem(.flexible(minimum: 100), spacing: 8, alignment: .center),
        GridItem(.flexible(minimum: 100), spacing: 8, alignment: .center)
    ]
    
    
    // MARK: Vue
    
    var body: some View {
        FondImageFloue(image: attraction.image) {
            ScrollView {
                VStack(spacing: 32) {
                    vueImage
                    
                    Text(attraction.nom)
                        .font(.grosTitre)
                        .foregroundStyle(Color.white)
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 16)
                    
                    vueInformations
                }
                .padding()
            }
        }
        .toolbar {
            ToolbarItem(placement: .bottomBar) {
                Button {
                    print("OK")
                } label: {
                    Image(systemName: "heart.fill")
                }
            }
            
            ToolbarSpacer(placement: .bottomBar)
        }
    }
    
    
    var vueImage: some View {
        GeometryReader { geometry in
            Image(attraction.image)
                .resizable()
                .scaledToFill()
                .frame(width: geometry.size.width, height: geometry.size.width) // carré
                .clipped() // coupe le débordement éventuel
        }
        .aspectRatio(1, contentMode: .fit)
        .bordureArrondie(rayon: 32, couleur: .white.opacity(0.2))
        .padding([.horizontal, .top], 48)
    }
    
    
    var vueInformations: some View {
        Group {
            if let informations = attraction.informations, informations.fonctionnement == .enMarche || informations.fonctionnement == .enPanne {
                VStack(spacing: 16) {
                    if informations.fonctionnement == .enMarche {
                        HStack(spacing: 16) {
                            CaseInformation(symboleTitre: "clock.fill", titre: "Attente", information: "\(informations.tempsAttente)", étiquetteDroite: "min")
                                .foregroundStyle(informations.tempsAttente.couleurAttente)
                            CaseInformation(symboleTitre: "figure.walk", symboleTitre2: "clock.fill", titre: "Marche + Attente", information: "44", étiquetteDroite: "min")
                            .foregroundStyle(44.couleurAttente)
                            if let singleRider = informations.tempsSingleRider {
                                CaseInformation(symboleTitre: "person.badge.clock.fill", titre: "Single Rider", information: "\(singleRider)" , étiquetteDroite: "min")
                                    .foregroundStyle(singleRider.couleurAttente)
                            }
                        }
                    }
                    
                    /*
                     HStack(spacing: 16) {
                     CaseInformation(symboleTitre: "figure.walk", titre: "Marche", information: "24", étiquetteDroite: "min")
                     CaseInformation(symboleTitre: "map.fill", titre: "Distance", information: "1,5", étiquetteDroite: "km")
                     }*/
                    
                    HStack(spacing: 16) {
                        if informations.fonctionnement == .enPanne {
                            CaseInformation(symbole: FonctionnementAttraction.enPanne.image, description: FonctionnementAttraction.enPanne.description)
                        }
                        if let fermeture = attraction.informations?.horaireFermeture {
                            CaseInformation(symboleTitre: FonctionnementAttraction.fermée.image, titre: "Fermeture", information: fermeture.enHoraire())
                        }
                    }
                }
            }
            
            else if let informations = attraction.informations {
                CaseInformation(symbole: informations.fonctionnement.image, description: informations.fonctionnement.description)
            }
            
            else {
                CaseInformation(symbole: "questionmark", description: "Aucune info sur l'attraction")
            }
        }
        .foregroundStyle(Color.white)
    }
}





#Preview {
    @Previewable @Namespace var namespace
    
    let attraction = Attraction(
        id: "P0AA00",
        nom: "Space Mountain",
        image: "Space Mountain",
        parc: .disneyland,
        univers: .frontierland
    )
    
    attraction.estFavorite = true
    
    attraction.modifierInformation(InformationsAttraction(
        tempsAttente: 20,
        tempsSingleRider: 5,
        horaireFermeture: Date(),
        fonctionnement: .enMarche
    ))
    
    return PageDetailAttraction2(namespace: namespace, attraction: attraction)
}
