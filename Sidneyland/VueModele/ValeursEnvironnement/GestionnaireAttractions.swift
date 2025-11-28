//
//  GestionnaireAttractions.swift
//  Sidneyland
//
//  Created by Thomas Le Bonnec on 19/11/2024.
//

import SwiftUI


class GestionnaireAttractions: ObservableObject {
    
    // MARK: Attributs
    
    @AppStorage("idAttractionsFavorites") var idAttractionsFavorites: [String] = []
    @Published var attractions: [Attraction] = []
    @Published var chargement: Bool = false             // TODO: Vérifier si chargement est toujours nécessaire
    
    
    
    // MARK: Init
    
    init() {
        raffraichirDonnéesAttractions()
    }
    
    
    
    // MARK: Méthodes
    
    // Chargement des attractions et des temps d'attente
    
    func raffraichirDonnéesAttractions() {
        chargement = true                       // TODO: Possiblement enlever cette ligne pour que le chargement ne soit vrai qu'au démarrage de l'appli, et faut tout le reste
        Task {
            do {
                let donnéesBruts = try await ServiceDisneyland.obtenirEtatsAttractions()
                let toutesAttractions = RegistreAttractions.attractions()
                
                for i in 0..<toutesAttractions.count {
                    let attraction = toutesAttractions[i]
                    let informations = donnéesBruts.informations.données.attractions.first { information in
                        information.id == attraction.id
                    }
                    let état = donnéesBruts.états.first { état in
                        état.id == attraction.id
                    }
                    if let informations {
                        let étatAttraction = EtatAttraction(information: informations, état: état)
                        toutesAttractions[i].état = étatAttraction
                    }
                }
                
                let nouvellesAttraction = toutesAttractions
                
                await MainActor.run {
                    self.attractions = nouvellesAttraction
                }
            } catch {
                print("AppVM - Erreur lors du raffraichissement des données")
            }
            
            await MainActor.run {
                self.chargement = false
                chargerAttractionsFavorites()
            }
        }
    }
    
    
    
    // Attraction Favorites
    
    func basculerAttractionFavorite(attraction: Attraction) {
        let nouveauStatutFavoris = !attraction.estFavorite
        
        if nouveauStatutFavoris {
            idAttractionsFavorites.append(attraction.id)
        } else {
            idAttractionsFavorites.removeAll { $0 == attraction.id }
        }
        
        attraction.estFavorite = nouveauStatutFavoris
    }
    
    
    private func chargerAttractionsFavorites() {
        for attraction in attractions {
            if let _ = idAttractionsFavorites.first(where: { $0 == attraction.id }) {
                attraction.estFavorite = true
            }
        }
    }
}
