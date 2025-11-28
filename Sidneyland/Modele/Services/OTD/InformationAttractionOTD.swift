//
//  InformationAttractionOTD.swift
//  Sidneyland
//
//  Created by Thomas Le Bonnec on 25/11/2025.
//

import Foundation


struct InformationAttractionOTD: Decodable {
    let id: String
    let calendrier: [Calendrier]
    
    enum CodingKeys: String, CodingKey {
        case id
        case calendrier = "schedules"
    }
    
    
    struct Calendrier: Decodable {
        let fermé: Bool
        let date: String
        let ouverture: String
        let fermeture: String
        let fonctionnement: String
        
        enum CodingKeys: String, CodingKey {
            case fermé = "closed"
            case date
            case ouverture = "startTime"
            case fermeture = "endTime"
            case fonctionnement = "status"
        }
    }
}


struct DonneesInformationAttractionOTD: Decodable {
    let données: Donnees
    
    enum CodingKeys: String, CodingKey {
        case données = "data"
    }
    
    
    struct Donnees: Decodable {
        let attractions: [InformationAttractionOTD]
        
        enum CodingKeys: String, CodingKey {
            case attractions = "Attraction"
        }
    }
}
