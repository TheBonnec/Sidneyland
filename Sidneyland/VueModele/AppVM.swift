//
//  AppVM.swift
//  Sidneyland
//
//  Created by Thomas Le Bonnec on 19/11/2024.
//

import SwiftUI


class AppVM: ObservableObject {
    
    // MARK: Attributs
    
    @AppStorage("idAttractionsFavorites") var idAttractionsFavorites: [String] = []
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
                await MainActor.run {
                    self.attractions = nouvellesAttraction
                    self.chargerAttractionFavorite()
                }
            } catch {
                print("AppVM - Erreur lors du raffraichissement des données")
            }
            
            await MainActor.run {
                self.chargement = false
            }
        }
    }
    
    
    func ajouterAttractionFavorite(attraction: Attraction) {
        let id = attraction.id
        guard !idAttractionsFavorites.contains(id) else { return }          // N'est pas déjà favorite
        guard attractions.contains(where: { $0.id == id }) else { return }  // Existe
        
        idAttractionsFavorites.append(id)
        attraction.estFavorite = true
    }
    
    
    func enleverAttractionFavorite(attraction: Attraction) {
        let id = attraction.id
        guard idAttractionsFavorites.contains(id) else { return }
        guard attractions.contains(where: { $0.id == id }) else { return }
        
        idAttractionsFavorites.removeAll(where: { $0 == id })
        attraction.estFavorite = false
    }
    
    
    private func chargerAttractionFavorite() {
        for attraction in attractions {
            for idAttractionFavorite in idAttractionsFavorites {
                if idAttractionFavorite == attraction.id {
                    attraction.estFavorite = true
                }
            }
        }
    }
    
}
