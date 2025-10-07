//
//  TitreSectionAttractions.swift
//  Sidneyland
//
//  Created by Thomas Le Bonnec on 06/10/2025.
//

import SwiftUI

struct TitreSectionAttractions: View {
    
    // MARK: Attributs
    
    var symbole: String?
    var titre: String
    var conteneuriser: Bool = false
    
    
    
    // MARK: Vue
    
    var body: some View {
        HStack(spacing: 8) {
            if let symbole {
                Image(systemName: symbole)
                    .font(.sousTitre)
            }
            
            Text(titre)
                .font(.titreSection)
                .padding(.trailing, 6)
            
            Image(systemName: "chevron.right")
                .font(.sousTitre)
            
            Spacer()
        }
        .padding(.leading)
        .if(conteneuriser) { vue in
            vue.padding(.leading, 2)
        }
        .foregroundStyle(Color.white)
    }
}






#Preview {
    FondImageFloue {
        TitreSectionAttractions(symbole: "heart.fill", titre: "Favoris")
    }
}
