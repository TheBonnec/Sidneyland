//
//  EtatAttraction.swift
//  Sidneyland
//
//  Created by Thomas Le Bonnec on 16/11/2024.
//

import Foundation


struct EtatAttraction {
    
    // MARK: Attributs
    
    let tempsAttente: Int
    let tempsSingleRider: Int?
    let horaireOuverture: Date?
    let horaireFermeture: Date?
    let fonctionnement: FonctionnementAttraction
    let dernièreMàJ = Date()
    
    
    
    // MARK: Inits
    
    init(tempsAttente: Int, tempsSingleRider: Int?, horaireOuverture: Date?, horaireFermeture: Date?, fonctionnement: FonctionnementAttraction) {
        self.tempsAttente = tempsAttente
        self.tempsSingleRider = tempsSingleRider
        self.horaireOuverture = horaireOuverture
        self.horaireFermeture = horaireFermeture
        self.fonctionnement = fonctionnement
    }
    
    init(information: InformationAttractionOTD, état: EtatAttractionOTD?) {
        if let état = état, let attente = Int(état.attente) {
            self.tempsAttente = attente
        } else {
            self.tempsAttente = 0
        }
        if let tempsSingleRiderStr = état?.singleRider.attente, let tempsSingleRider = Int(tempsSingleRiderStr) {
            self.tempsSingleRider = tempsSingleRider
        } else {
            self.tempsSingleRider = nil
        }
        if let calendrier = information.calendrier[safe: 0] {
            self.horaireOuverture = calendrier.ouverture.convertirEnDate()
            self.horaireFermeture = calendrier.fermeture.convertirEnDate()
        } else {
            self.horaireOuverture = nil
            self.horaireFermeture = nil
        }
        
        self.fonctionnement = EtatAttraction.calculerFonctionnement(information: information, état: état)
    }
    
    
    
    // MARK: Méthodes
    
    static private func calculerFonctionnement(information: InformationAttractionOTD, état: EtatAttractionOTD?) -> FonctionnementAttraction {
        let fonctionne = "OPERATING"
        let travaux = "REFURBISHMENT"
        let panne = "DOWN"
        
        let fonctionnementInformations: String
        if let calendrier = information.calendrier[safe: 0] {
            fonctionnementInformations = calendrier.fonctionnement
        } else {
            fonctionnementInformations = "UNKNOWN"
        }
        let fonctionnementÉtat = état?.fonctionnement
        
        
        var fonctionnement: FonctionnementAttraction
        
        if fonctionnementInformations == travaux {          // Si informations marquent travaux, alors travaux
            fonctionnement = .enTravaux
        } else if fonctionnementInformations == fonctionne && fonctionnementÉtat == nil {       // Si informations marquent ouvert mais aucun état (après minuit par exemple) alors attraction fermée
            fonctionnement = .fermée
        } else {
            switch fonctionnementÉtat {
            case fonctionne: fonctionnement = .enMarche
            case travaux: fonctionnement = .fermée
            case panne: fonctionnement = .enPanne
            default: fonctionnement = .inconnu
            }
        }
        
        return fonctionnement
    }
}

