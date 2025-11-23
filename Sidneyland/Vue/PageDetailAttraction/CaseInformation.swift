//
//  CaseInformation.swift
//  Sidneyland
//
//  Created by Thomas Le Bonnec on 22/11/2025.
//

import SwiftUI

struct CaseInformation: View {
    
    // MARK: Attributs
    
    var symboleTitre: String? = nil
    var symboleTitre2: String? = nil
    var titre: String? = nil
    var information: String? = nil
    var étiquetteGauche: String? = nil
    var étiquetteDroite: String? = nil
    var symbole: String? = nil
    var description: String? = nil
    
    
    // MARK: Init
    
    /// Pour le temps d'attente et la distance
    init(symboleTitre: String, symboleTitre2: String? = nil, titre: String, information: String, étiquetteDroite: String) {
        self.symboleTitre = symboleTitre
        self.symboleTitre2 = symboleTitre2
        self.titre = titre
        self.information = information
        self.étiquetteDroite = étiquetteDroite
    }
    
    /// Pour l'horaire
    init(symboleTitre: String, titre: String, information: String) {
        self.symboleTitre = symboleTitre
        self.titre = titre
        self.information = information
    }
    
    
    /// Autres infos
    init(symbole: String, description: String) {
        self.symbole = symbole
        self.description = description
    }
    
    
    
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 4) {
                HStack(spacing: 4) {
                    if let symboleTitre {
                        Image(systemName: symboleTitre)
                    }
                    if let symboleTitre2 {
                        Text("+")
                        Image(systemName: symboleTitre2)
                    }
                }
                .font(.corps)
                .foregroundStyle(Color.white.opacity(0.5))
                
                if let titre {
                    Text(titre)
                        .font(.noteImportante)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(Color.white)
                }
            }
            .frame(height: (symboleTitre != nil || titre != nil) ? 56 : 0)
            
            
            HStack(alignment: .firstTextBaseline, spacing: 4) {
                if let étiquetteGauche {
                    Text(étiquetteGauche)
                        .font(.note)
                }
                if let information {
                    Text(information)
                        .font(.informationImportante)
                }
                if let étiquetteDroite {
                    Text(étiquetteDroite)
                        .font(.note)
                }
            }
            .frame(height: information != nil ? 40 : 0)
            
            
            VStack(spacing: 12) {
                if let symbole {
                    Image(systemName: symbole)
                        .font(.informationImportante)
                }
                if let description {
                    Text(description)
                        .font(.description)
                }
            }
            .frame(height: (symbole != nil || description != nil) ? 96 : 0)
        }
        .padding(16)
        .frame(maxWidth: .infinity)
        .background(Color.white.opacity(0.16))
        .bordureArrondie(rayon: 24)
    }
}





#Preview {
    FondImageFloue {
        CaseInformation(
            symboleTitre: "clock.fill",
            symboleTitre2: "figure.walk",
            titre: "Attente + Marche",
            information: "22",
            étiquetteDroite: "min"
        )
    }
}
