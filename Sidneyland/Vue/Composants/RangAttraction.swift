//
//  RangAttraction.swift
//  Sidneyland
//
//  Created by Thomas Le Bonnec on 19/11/2024.
//

import SwiftUI

struct RangAttraction: View {
    
    // MARK: Attributs
    
    var attraction: Attraction
    
    
    
    // MARK: Vue
    
    var body: some View {
        HStack(spacing: 16) {
            if let image = attraction.image {
                Image(image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 60, height: 60)
                    .bordureArrondie(rayon: 8)
            }
            
            VStack(alignment: .leading, spacing: 3) {
                Text(attraction.nomCourt ?? attraction.nom)
                    .font(.corpsImportant)
                
                Text(attraction.parc.rawValue)
                    .font(.description)
                    .foregroundStyle(Color.gray)
            }
            
            Spacer()
            
            if let informations = attraction.informations {
                IndicateurAttente(tempsAttente: informations.tempsAttente, fonctionnement: informations.fonctionnement)
            }
        }
    }
}





#Preview {
    var attraction = Attraction(
        id: "P0AA00",
        nom: "Big Thunder Mountain",
        parc: .disneyland,
        univers: .frontierland
    )
    
    attraction.modifierInformation(InformationsAttraction(
        tempsAttente: 15,
        tempsSingleRider: nil,
        fonctionnement: .enMarche
    ))
    
    return RangAttraction(attraction: attraction)
}
