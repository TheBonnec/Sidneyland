//
//  Attraction.swift
//  Sidneyland
//
//  Created by Thomas Le Bonnec on 15/09/2024.
//

import SwiftUI


class Attraction: Identifiable {
    
    // MARK: Attributs
    
    let id: String
    let nom: String
    let nomCourt: String?
    let image: String
    let couleur: String?
    let parc: NomParc
    let univers: NomUnivers
    var informations: InformationsAttraction?
    let positionCarte: UnitPoint?
    let importance: Int?
    var estFavorite: Bool = false
    
    
    
    // MARK: Init
    
    init(id: String, nom: String, nomCourt: String? = nil, image: String, couleur: String? = nil, parc: NomParc, univers: NomUnivers, positionCarte: UnitPoint? = nil, importance: Int? = nil) {
        self.id = id
        self.nom = nom
        self.nomCourt = nomCourt
        self.image = image
        self.couleur = couleur
        self.parc = parc
        self.univers = univers
        self.positionCarte = positionCarte
        self.importance = importance
    }
    
    
    
    // MARK: Méthodes
    
    func modifierInformation(_ informations: InformationsAttraction) {
        self.informations = informations
    }
}
