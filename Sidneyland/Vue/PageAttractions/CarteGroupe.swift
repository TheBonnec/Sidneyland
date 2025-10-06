//
//  CarteGroupe.swift
//  Sidneyland
//
//  Created by Thomas Le Bonnec on 06/10/2025.
//

import SwiftUI

struct CarteGroupe: View {
    
    // MARK: Attributs
    
    var namespace: Namespace.ID
    var titre: String
    var image: String
    var attractions: [Attraction]
    
    
    
    // MARK: Vue
    
    var body: some View {
        NavigationLink {
            PageDetailSection(namespace: namespace, titre: titre, image: image, attractions: attractions)
        } label: {
            illustration
        }
    }
    
    
    var illustration: some View {
        GeometryReader { geo in
            VStack {
                Spacer()
                
                Text(titre)
                    .font(.corpsImportant)
                    .foregroundStyle(Color.white)
                    .padding(.horizontal, 14)
                    .padding(.bottom, 16)
                    .padding(.top, 20)
                    .frame(maxWidth: .infinity)
                    .background {
                        VariableBlurView(maxBlurRadius: 16)
                    }
            }
            .background {
                Image(image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: geo.size.width, height: geo.size.height)
                    .clipped()
            }
            .bordureArrondie(rayon: 32)
        }
        .frame(height: 128)
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
    
    
    return FondPrincipal {
        CarteGroupe(namespace: namespace, titre: "Frontierland", image: "BTM", attractions: attractions)
    }
}
