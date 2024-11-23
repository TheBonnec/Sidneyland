//
//  CartoucheGlossaire.swift
//  Sidneyland
//
//  Created by Thomas Le Bonnec on 19/11/2024.
//

import SwiftUI

struct CartoucheGlossaire: View {
    
    // MARK: Attributs
    
    let fonctionnements: [FonctionnementAttraction] = [.enPanne, .fermée, .enTravaux, .inconnu]
    
    
    
    // MARK: Vue
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            ForEach(fonctionnements, id: \.self) { fonctionnement in
                HStack(spacing: 12) {
                    Image(systemName: fonctionnement.image)
                        .frame(width: 19)
                    
                    Text(fonctionnement.description)
                }
            }
        }
        .font(.description)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color.fondSecondaire)
        .foregroundStyle(Color.gray)
        .bordureArrondie(rayon: 8)
        .shadow(color: .black.opacity(0.1), radius: 8)
    }
}





#Preview {
    CartoucheGlossaire()
}
