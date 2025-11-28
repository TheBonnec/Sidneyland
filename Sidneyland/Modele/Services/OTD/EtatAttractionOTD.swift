//
//  EtatAttractionOTD.swift
//  Sidneyland
//
//  Created by Thomas Le Bonnec on 25/11/2025.
//

import Foundation


struct EtatAttractionOTD: Decodable {
    let id: String
    let attente: String
    let miseÀJour: String
    let singleRider: SingleRider
    let fonctionnement: String
    
    enum CodingKeys: String, CodingKey {
        case id = "entityId"
        case attente = "postedWaitMinutes"
        case miseÀJour = "responseTimestamp"
        case singleRider
        case fonctionnement = "status"
    }
    
    
    struct SingleRider: Decodable {
        let disponible: Bool
        let attente: String?
        
        enum CodingKeys: String, CodingKey {
            case disponible = "isAvailable"
            case attente = "singleRiderWaitMinutes"
        }
    }
}
