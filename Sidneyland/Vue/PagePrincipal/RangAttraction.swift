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
    @EnvironmentObject var appVM: AppVM
    
    var attraction: Attraction
    
    
    
    // MARK: Vue
    
    var body: some View {
        HStack(spacing: 16) {
            if !(appVM.détailEstAffiché && appVM.attractionSélectionnée?.id == attraction.id) {
                VStack {
                    Image(attraction.image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .matchedGeometryEffect(id: "Image-\(attraction.id)", in: namespace)
                }
                .frame(width: 60, height: 60)
                .mask {
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                        .matchedGeometryEffect(id: "MasqueImage-\(attraction.id)", in: namespace)
                }
                
            } else {
                // Remplacement transparent pour la photo
                Rectangle()
                    .opacity(0)
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
                }
            }
            .zIndex(-2)
            
            Spacer()
            
            if let informations = attraction.informations {
                IndicateurAttente(tempsAttente: informations.tempsAttente, fonctionnement: informations.fonctionnement)
            }
        }
        .zIndex(appVM.attractionSélectionnée?.id == attraction.id ? 10 : -1)
    }
}





#Preview {
    @Previewable @Namespace var animationRangAttraction
    
    var attraction = Attraction(
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
}
