//
//  IndicateurAttente.swift
//  Sidneyland
//
//  Created by Thomas Le Bonnec on 19/11/2024.
//

import SwiftUI

struct IndicateurAttente: View {
    
    // MARK: Attributs
    
    var tempsAttente: Int
    var fonctionnement: FonctionnementAttraction
    
    @Environment(\.colorScheme) var colorScheme
    
    
    
    
    
    // MARK: Vue
    
    var body: some View {
        Group {
            if fonctionnement == .enMarche {
                vueChiffre
                    //.padding(.horizontal, 16)
            } else {
                // Vue symbole
                Image(systemName: symbole())
                    //.frame(width: 48)
            }
        }
        //.frame(height: 48)
        //.foregroundStyle(Color.white)
        //.background(couleurAccent())
        .foregroundStyle(couleurAccent())
        //.bordureArrondie(rayon: 1000)
    }
    
    
    var vueChiffre: some View {
        //HStack(alignment: .firstTextBaseline, spacing: 4) {
        VStack(spacing: 0) {
            Text("\(tempsAttente)")
                .font(.information)
            
            Text("min")
                .font(.note)
        }
    }
    
    
    
    
    
    // MARK: Méthode
    
    func couleurAccent() -> Color {
        if fonctionnement == .enMarche {
            if tempsAttente <= 15 {
                return .green
            } else if tempsAttente <= 30 {
                return .orange
            } else if tempsAttente <= 60 {
                return .red
            }
            return .purple
        }
        
        return .white.opacity(0.64)
    }
    
    
    func symbole() -> String {
        return switch fonctionnement {
        case .enMarche: ""
        case .enPanne: "exclamationmark.triangle.fill"
        case .fermée: "xmark.octagon.fill"
        case .enTravaux: "wrench.and.screwdriver.fill"
        case .inconnu: "questionmark"
        }
    }
}





#Preview {
    IndicateurAttente(
        tempsAttente: 15,
        fonctionnement: .enMarche
    )
}
