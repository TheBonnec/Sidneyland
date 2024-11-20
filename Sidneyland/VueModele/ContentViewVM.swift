//
//  ContentViewVM.swift
//  Sidneyland
//
//  Created by Thomas Le Bonnec on 19/11/2024.
//

import Foundation


class ContentViewVM: ObservableObject {
    
    // MARK: Attributs
    
    @Published var attractions: [Attraction] = []
    @Published var chargement: Bool = false
    
    
    
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
                print("ContentViewVM - Erreur lors du raffraichissement des données")
            }
            
            DispatchQueue.main.async {
                self.chargement = false
            }
        }
    }
}
