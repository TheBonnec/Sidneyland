//
//  RangAttraction.swift
//  Sidneyland
//
//  Created by Thomas Le Bonnec on 19/11/2024.
//

import SwiftUI

struct RangAttraction: View {
    
    // MARK: Attributs
    
    var namespace: Namespace.ID
    var attraction: Attraction
    
    @EnvironmentObject var vm: DetailAttractionVM
    @EnvironmentObject var sélectionOnglet: SelectionOnglet
    
    
    
    // MARK: Vue
    
    var body: some View {
        HStack(spacing: 16) {
            if !(vm.détailEstAffiché && vm.attractionSélectionnée?.id == attraction.id) {
                vueImage
                    .matchedGeometryEffect(id: "\(attraction.id)-P\(sélectionOnglet.sélection)", in: namespace, properties: .frame, isSource: true)
                    .transition(.invisible)
            } else {
                Color.clear
                    .frame(width: 60, height: 60)
            }
            
            VStack(alignment: .leading, spacing: 3) {
                Text(attraction.nomCourt ?? attraction.nom)
                    .font(.corpsImportant)
                
                HStack(spacing: 5) {
                    Image(attraction.parc.symbole)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 15)
                    
                    Text(attraction.parc.rawValue)
                        .font(.description)
                        .foregroundStyle(Color.gray)
                    
                    if attraction.estFavorite {
                        Image(systemName: "heart.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 15)
                            .foregroundStyle(Color.purple)
                    }
                }
            }
            
            Spacer()
            
            if let informations = attraction.informations {
                IndicateurAttente(tempsAttente: informations.tempsAttente, fonctionnement: informations.fonctionnement)
            }
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
            .mask {
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    //.frame(width: 60, height: 60)
            }
            .frame(width: 60, height: 60)
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
    
    attraction.modifierInformation(InformationsAttraction(
        tempsAttente: 15,
        tempsSingleRider: nil,
        horaireFermeture: Date(),
        fonctionnement: .enMarche
    ))
    
    return RangAttraction(namespace: animationRangAttraction, attraction: attraction)
        .environmentObject(AppVM())
        .environmentObject(DetailAttractionVM())
        .environmentObject(SelectionOnglet())
}
