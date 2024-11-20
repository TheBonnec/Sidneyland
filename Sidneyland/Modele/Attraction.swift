//
//  Attraction.swift
//  Sidneyland
//
//  Created by Thomas Le Bonnec on 15/09/2024.
//

import Foundation


struct Attraction: Identifiable {
    let id: String
    let nom: String
    let nomCourt: String?
    let image: String?
    let parc: NomParc
    let univers: NomUnivers
    var informations: InformationsAttraction?
    
    init(id: String, nom: String, nomCourt: String? = nil, image: String? = nil, parc: NomParc, univers: NomUnivers) {
        self.id = id
        self.nom = nom
        self.nomCourt = nomCourt
        self.image = image
        self.parc = parc
        self.univers = univers
    }
    
    
    mutating func modifierInformation(_ informations: InformationsAttraction) {
        self.informations = informations
    }
}
