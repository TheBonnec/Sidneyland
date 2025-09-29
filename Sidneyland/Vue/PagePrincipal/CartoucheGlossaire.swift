//
//  CartoucheGlossaire.swift
//  Sidneyland
//
//  Created by Thomas Le Bonnec on 19/11/2024.
//

import SwiftUI

struct CartoucheGlossaire: View {
    
    // MARK: Attributs
    
    @Environment(\.colorScheme) var modeLumière
    let fonctionnements: [FonctionnementAttraction] = [.enPanne, .fermée, .enTravaux, .inconnu]
    
    
    
    // MARK: Vue
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            ForEach(fonctionnements, id: \.self) { fonctionnement in
                HStack(spacing: 12) {
                    Image(systemName: fonctionnement.image)
                        .frame(width: 19)
                    
                    Text(fonctionnement.description)
                        .foregroundStyle(Color.white.opacity(0.64))
                }
            }
        }
        .font(.description)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(24)
        .foregroundStyle(Color.white)
        .glassEffect(teinteFond.interactive(), in: .rect(cornerRadius: 32, style: .continuous))
    }
    
    
    
    // MARK: Propriétés Calculées
    
    var teinteFond: Glass {
        if modeLumière == .light {
            return .regular.tint(.black.opacity(0.76))
        }
        return .regular
    }
}





#Preview {
    FondPrincipal(image: "Chateau") {
        CartoucheGlossaire()
    }
}
