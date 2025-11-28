//
//  PageDetailAttraction.swift
//  Sidneyland
//
//  Created by Thomas Le Bonnec on 30/09/2025.
//

import SwiftUI
import Charts


struct PageDetailAttraction: View {
    
    // MARK: Attributs
    
    var namespace: Namespace.ID
    var attraction: Attraction
    
    @EnvironmentObject var appVM: GestionnaireAttractions
    
    let rangs = [
        GridItem(.flexible(minimum: 100), spacing: 8, alignment: .center),
        GridItem(.flexible(minimum: 100), spacing: 8, alignment: .center)
    ]
    
    
    // MARK: Vue
    
    var body: some View {
        NavigationStack {
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
                .scrollIndicators(.hidden)
            }
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    Button {
                        appVM.basculerAttractionFavorite(attraction: attraction)
                    } label: {
                        Image(systemName: attraction.estFavorite ? "heart.fill" : "heart.slash")
                    }
                }
                
                ToolbarSpacer(placement: .bottomBar)
            }
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
            if let informations = attraction.état, informations.fonctionnement != .enTravaux && informations.fonctionnement != .inconnu {
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
                        if informations.fonctionnement == .enPanne || informations.fonctionnement == .fermée {
                            CaseInformation(symbole: informations.fonctionnement.image, description: informations.fonctionnement.description)
                        }
                        
                        if informations.fonctionnement != .enPanne, let ouverture = attraction.état?.horaireOuverture {
                            CaseInformation(symboleTitre: "checkmark.app.fill", titre: "Ouverture", information: ouverture.convertirEnHeure())
                        }
                        if informations.fonctionnement != .fermée, let fermeture = attraction.état?.horaireFermeture {
                            CaseInformation(symboleTitre: FonctionnementAttraction.fermée.image, titre: "Fermeture", information: fermeture.convertirEnHeure())
                        }
                    }
                }
            }
            
            else if let informations = attraction.état {
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
    
    attraction.état = EtatAttraction(
        tempsAttente: 20,
        tempsSingleRider: 5,
        horaireOuverture: Date(),
        horaireFermeture: Date(),
        fonctionnement: .enMarche
    )
    
    return PageDetailAttraction(namespace: namespace, attraction: attraction)
        .environmentObject(GestionnaireAttractions())
}
