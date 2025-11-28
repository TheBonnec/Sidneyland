//
//  BulleTempsAttente.swift
//  Sidneyland
//
//  Created by Thomas Le Bonnec on 27/11/2025.
//

import SwiftUI

struct BulleTempsAttente: View {
    
    // MARK: Attributs
    
    @Bindable var attraction: Attraction
    
    @Environment(\.ouvrirDétailAttraction) var ouvrirDétailAttraction
    
    
    
    // MARK: Vue
    
    var body: some View {
        ZStack {
            if let état = attraction.état {
                if état.fonctionnement == .enMarche {
                    vueAttente(attente: état.tempsAttente)
                } else {
                    vueÉtat(fonctionnement: état.fonctionnement)
                }
            } else {
                vueÉtat(fonctionnement: .inconnu)
            }
            
            if attraction.estFavorite {
                badgeFavoris
                    .offset(x: 34/2, y: -34/2)
            }
        }
        .frame(width: 44, height: 44)
        .foregroundStyle(Color.white)
        .background(couleurDeFond
            .bordureArrondie(rayon: 1000, épaisseur: 2, couleur: .white.opacity(0.5))
        )
        .shadow(color: .black.opacity(0.5), radius: 8)
        .onTapGesture {
            ouvrirDétailAttraction(attraction)
        }
    }
    
    
    @ViewBuilder
    func vueAttente(attente: Int) -> some View {
        Text("\(attente)")
            .font(.information)
    }
    
    
    @ViewBuilder
    func vueÉtat(fonctionnement: FonctionnementAttraction) -> some View {
        Image(systemName: fonctionnement.image)
            .font(.information)
    }
    
    
    var badgeFavoris: some View {
        VStack {
            HStack {
                Spacer()
                
                Image(systemName: "heart.fill")
                    .foregroundStyle(Color.white)
                    .frame(width: 34, height: 34)
                    .background(Rectangle().fill(.ultraThinMaterial))
                    .bordureArrondie(rayon: 1000)
            }
            Spacer()
        }
    }
    
    
    
    // MARK: Méthodes
    
    var couleurDeFond: Color {
        if let état = attraction.état, état.fonctionnement == .enMarche {
            return état.tempsAttente.couleurAttente
        } else {
            return .gray
        }
    }
}





#Preview {
    @Previewable @State var attraction = Attraction(
        id: "P0AA00",
        nom: "Big Thunder Mountain",
        image: "BTM",
        parc: .disneyland,
        univers: .frontierland
    )
    
    attraction.estFavorite = true
    
    attraction.état = EtatAttraction(
        tempsAttente: 15,
        tempsSingleRider: 5,
        horaireOuverture: Date(),
        horaireFermeture: Date(),
        fonctionnement: .enMarche
    )
    
    return ZStack {
        Color.gray
        
        BulleTempsAttente(attraction: attraction)
    }
}
