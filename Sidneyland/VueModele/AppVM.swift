//
//  AppVM.swift
//  Sidneyland
//
//  Created by Thomas Le Bonnec on 19/11/2024.
//

import SwiftUI


class AppVM: ObservableObject {
    
    // MARK: Attributs
    
    @Published var attractions: [Attraction] = []
    @Published var chargement: Bool = false
    
    @Published var attractionSélectionnée: Attraction?
    @Published var détailEstAffiché: Bool = false
    
    
    
    // MARK: Init
    
    init() {
        raffraichirDonnéesAttractions()
    }
    
    
    
    // MARK: Méthodes
    
    func raffraichirDonnéesAttractions() {
        chargement = true
        Task {
            do {
                let nouvellesAttraction = try await GestionnaireAttractions.obtenirDonnéesAttractions()
                DispatchQueue.main.async {
                    self.attractions = nouvellesAttraction
                }
            } catch {
                print("AppVM - Erreur lors du raffraichissement des données")
            }
            
            DispatchQueue.main.async {
                self.chargement = false
            }
        }
    }
    
    
    func ouvrirDétail(attraction: Attraction) {
        withAnimation(.spring(duration: 0.3, bounce: 0.2)) {
            attractionSélectionnée = attraction
            détailEstAffiché = true
        }
    }
    
    
    func fermerDétail() {
        withAnimation(.spring(duration: 0.2, bounce: 0.2)) {
            détailEstAffiché = false
        }
    }
}
