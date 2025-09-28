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
            } else {
                vueSymbole
            }
        }
        .foregroundStyle(couleurAccent())
        .bordureArrondie(rayon: 8)
    }
    
    
    var vueChiffre: some View {
        VStack(spacing: 0) {
            Text("\(tempsAttente)")
                .font(.information)
            
            Text("min")
                .font(.note)
        }
        .frame(width: 50, height: 60)
        .background(couleurAccent().opacity(opacité()))
    }
    
    
    var vueSymbole: some View {
        Group {
            Image(systemName: symbole())
        }
        .frame(width: 50, height: 60)
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
        
        return .gray
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
    
    
    func opacité() -> Double {
        if colorScheme == .dark {
            return 0.15
        }
        return 0.08
    }
}





#Preview {
    IndicateurAttente(
        tempsAttente: 15,
        fonctionnement: .enMarche
    )
}
