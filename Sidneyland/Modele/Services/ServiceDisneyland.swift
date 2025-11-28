//
//  APIDisneyland.swift
//  Sidneyland
//
//  Created by Thomas Le Bonnec on 15/09/2024.
//

import Foundation


class ServiceDisneyland {
    
    static func obtenirEtatsAttractions() async throws -> (informations: DonneesInformationAttractionOTD, états: [EtatAttractionOTD]) {
        let informations = try await chargerInformationsAttractions()
        let états = try await chargerÉtatAttractions()
        
        return (informations, états)
    }
    
    
    
    
    
    // MARK: Fonctions privées
    
    static private func chargerÉtatAttractions() async throws -> [EtatAttractionOTD] {
        let url = "https://dlp-wt.wdprapps.disney.com/prod/v1/waitTimes"
        let entêtes = [
            ElementEntete(champs: "x-api-key", contenu: "3jPT5qMimN3kR2kxqd1ez9iF1C68CrBf7zw5ICo4")
        ]
        
        let données = try await ServiceHTTP.requêteHTTP(url: url, méthode: .get, élémentsEntête: entêtes)
        return try JSONDecoder().decode([EtatAttractionOTD].self, from: données)
    }
    
    
    
    
    static private func chargerInformationsAttractions() async throws -> DonneesInformationAttractionOTD {
        let url = "https://api.disneylandparis.com/query"
        let corps: [String: Any] = [
            "query": """
            query activities($market: String!) {
                Attraction: activities(market: $market, types: "Attraction") {
                    id
                    type: __typename
                    hideFunctionality
                    schedules {
                        language
                        date
                        startTime
                        endTime
                        status
                        closed
                    }
                }
            }
            """,
            "variables": ["market": "fr-fr"]
        ]
        
        let données = try await ServiceHTTP.requêteHTTP(url: url, méthode: .post, élémentsEntête: [], corps: corps)
        return try JSONDecoder().decode(DonneesInformationAttractionOTD.self, from: données)
    }
}
