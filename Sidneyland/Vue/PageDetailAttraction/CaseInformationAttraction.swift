//
//  CaseInformationAttraction.swift
//  Sidneyland
//
//  Created by Thomas Le Bonnec on 21/11/2024.
//

import SwiftUI

struct CaseInformationAttraction: View {
    
    // MARK: Attributs
    
    var libellé: String
    var valeur: String
    var estTempsAttente: Bool
    
    
    
    // MARK: Vue
    
    var body: some View {
        VStack(spacing: 4) {
            Text(libellé)
                .font(.description)
                .foregroundStyle(couleur())
            
            Text(valeur)
                .font(.information)
                .foregroundStyle(couleur())
        }
        .frame(maxWidth: .infinity)
    }
    
    
    
    // MARK: Méthodes
    
    func couleur() -> Color {
        if estTempsAttente, let tempsAttente = Int(valeur) {
            if tempsAttente <= 15 {
                return .green
            } else if tempsAttente <= 30 {
                return .orange
            } else if tempsAttente <= 60 {
                return .red
            }
            return .purple
        }
        return .white
    }
}





#Preview {
    CaseInformationAttraction(
        libellé: "Attente",
        valeur: "15",
        estTempsAttente: true
    )
}
