//
//  IndicateurAttente.swift
//  Sidneyland
//
//  Created by Thomas Le Bonnec on 19/11/2024.
//

import SwiftUI

struct IndicateurAttente: View {
    
    // MARK: Attributs
    
    // TODO: Mettre le temps d'attente en paramètre de .marche(Int)
    // TODO: Mettre la fonction de couleur de FonctionnementAttraction
    var tempsAttente: Int
    var fonctionnement: FonctionnementAttraction
    
    @Environment(\.colorScheme) var colorScheme
    
    
    
    
    
    // MARK: Vue
    
    var body: some View {
        Group {
            if fonctionnement == .enMarche {
                HStack(alignment: .firstTextBaseline, spacing: 3) {
                    vueChiffre
                }
            } else {
                // Vue symbole
                Image(systemName: fonctionnement.image)
                    .font(.descriptionImportante)
            }
        }
        .foregroundStyle(couleurAccent)
        .padding(.vertical, 5)
        .padding(.horizontal, 12)
        .frame(minHeight: 28.4)
        .background(.black.opacity(0.5).blendMode(.overlay))
        .bordureArrondie(rayon: 1000)
    }
    
    
    var vueChiffre: some View {
        Group {
            Text("\(tempsAttente)")
                .font(.corpsImportant)
            
            Text("min")
                .font(.note)
        }
    }
    
    
    
    
    
    // MARK: Propriétés Calculées
    
    var couleurAccent: Color {
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
}





#Preview {
    FondPrincipal {
        VStack {
            IndicateurAttente( tempsAttente: 15, fonctionnement: .enMarche)
            IndicateurAttente( tempsAttente: 30, fonctionnement: .enMarche)
            IndicateurAttente( tempsAttente: 45, fonctionnement: .enMarche)
            IndicateurAttente( tempsAttente: 75, fonctionnement: .enMarche)
            
            IndicateurAttente( tempsAttente: 15, fonctionnement: .enPanne)
            IndicateurAttente( tempsAttente: 15, fonctionnement: .fermée)
            IndicateurAttente( tempsAttente: 15, fonctionnement: .enTravaux)
            IndicateurAttente( tempsAttente: 15, fonctionnement: .inconnu)
        }
    }
}
