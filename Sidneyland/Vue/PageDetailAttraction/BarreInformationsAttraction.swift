//
//  BarreInformationsAttraction.swift
//  Sidneyland
//
//  Created by Thomas Le Bonnec on 21/11/2024.
//

import SwiftUI

struct BarreInformationsAttraction: View {
    
    // MARK: Attributs
    
    var informations: InformationsAttraction?
    var couleur: String?
    
    
    
    // MARK: Vue
    
    var body: some View {
        HStack {
            if informations != nil {
                vueInformations
            } else {
                vueFonctionnementAltéré
            }
        }
        .padding()
        .frame(maxWidth: .infinity, minHeight: 79)
        .background(Color(hex: couleur ?? "#3E2500"))
        .bordureArrondie(rayon: 12)
    }
    
    
    var vueInformations: some View {
        Group {
            if let informations {
                if informations.fonctionnement == .enMarche {
                    vueEnMarche
                } else  {
                    vueFonctionnementAltéré
                }
            }
        }
    }
    
    
    var vueEnMarche: some View {
        Group {
            if let informations {
                    CaseInformationAttraction(libellé: "Attente", valeur: "\(informations.tempsAttente)", estTempsAttente: true)
                
                if let singleRider = informations.tempsSingleRider {
                        CaseInformationAttraction(libellé: "Single Rider", valeur: "\(singleRider)", estTempsAttente: true)
                }
                
                if let horaireFermeture = informations.horaireFermeture {
                    CaseInformationAttraction(libellé: "Fermeture", valeur: horaireFermeture.enHoraire(), estTempsAttente: false)
                }
            }
        }
    }
    
    
    var vueFonctionnementAltéré: some View {
        VStack(spacing: 6) {
            if let informations {
                Image(systemName: informations.fonctionnement.image)
                    .font(.corps)
                
                Text(informations.fonctionnement.description)
                    .font(.description)
            }
        }
        .foregroundStyle(Color.white)
    }
    
    
    
    // MARK: Méthodes
    
    func couleurAttente(tempsAttente: Int) -> Color {
        if tempsAttente <= 15 {
            return .green
        } else if tempsAttente <= 30 {
            return .orange
        } else if tempsAttente <= 60 {
            return .red
        }
        return .purple
    }
}





#Preview {
    BarreInformationsAttraction(
        informations: InformationsAttraction(
            tempsAttente: 15,
            tempsSingleRider: 5,
            horaireFermeture: Date(),
            fonctionnement: .enPanne
        ),
        couleur: "#3E2500"
    )
}
