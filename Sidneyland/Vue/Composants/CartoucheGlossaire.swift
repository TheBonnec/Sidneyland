//
//  CartoucheGlossaire.swift
//  Sidneyland
//
//  Created by Thomas Le Bonnec on 19/11/2024.
//

import SwiftUI

struct CartoucheGlossaire: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(spacing: 12) {
                Image(systemName: "exclamationmark.triangle.fill")
                    .frame(width: 19)
                
                Text("Attraction en panne")
            }
            
            HStack(spacing: 12) {
                Image(systemName: "xmark.octagon.fill")
                    .frame(width: 19)
                
                Text("Attraction fermée")
            }
            
            HStack(spacing: 12) {
                Image(systemName: "wrench.and.screwdriver.fill")
                    .frame(width: 19)
                
                Text("Attraction en travaux")
            }
            
            HStack(spacing: 12) {
                Image(systemName: "questionmark")
                    .frame(width: 19)
                
                Text("Aucune info sur l'attraction")
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
