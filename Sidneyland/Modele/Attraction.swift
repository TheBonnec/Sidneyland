//
//  Attraction.swift
//  Sidneyland
//
//  Created by Thomas Le Bonnec on 15/09/2024.
//

import Foundation


struct Attraction: Identifiable {
    
    // MARK: Attributs
    
    let id: String
    let nom: String
    let nomCourt: String?
    let image: String
    let couleur: String?
    let parc: NomParc
    let univers: NomUnivers
    var informations: InformationsAttraction?
    
    
    
    // MARK: Init
    
    init(id: String, nom: String, nomCourt: String? = nil, image: String, couleur: String? = nil, parc: NomParc, univers: NomUnivers) {
        self.id = id
        self.nom = nom
        self.nomCourt = nomCourt
        self.image = image
        self.couleur = couleur
        self.parc = parc
        self.univers = univers
    }
    
    
    
    // MARK: Méthodes
    
    mutating func modifierInformation(_ informations: InformationsAttraction) {
        self.informations = informations
    }
}
