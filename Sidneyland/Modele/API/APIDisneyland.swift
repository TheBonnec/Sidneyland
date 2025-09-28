//
//  APIDisneyland.swift
//  Sidneyland
//
//  Created by Thomas Le Bonnec on 15/09/2024.
//

import Foundation


class APIDisneyland {
    
    static func obtenirDonnéesBrutsAttractions() async throws -> (informations: [[String: Any]], états: [[String: Any]]) {
        let informations = try await obtenirInformationsAttractions()
        let états = try await obtenirÉtatAttractions()
        
        return (informations, états)
    }
    
    
    
    
    
    // MARK: Fonctions privées
    
    static private func obtenirÉtatAttractions() async throws -> [[String: Any]] {
        let url = "https://dlp-wt.wdprapps.disney.com/prod/v1/waitTimes"
        let entêtes = [
            ElementEntete(champs: "x-api-key", contenu: "3jPT5qMimN3kR2kxqd1ez9iF1C68CrBf7zw5ICo4")
        ]
        
        let json = try await requêteHTTP(url: url, méthode: .get, élémentsEntête: entêtes)
        return parserÉtatAttractionsJSON(from: json) ?? [[:]]
    }
    
    
    
    static private func parserÉtatAttractionsJSON(from json: Any) -> [[String: Any]]? {
        // Vérifier que le JSON est un tableau de dictionnaires
        guard let jsonArray = json as? [[String: Any]] else {
            print("Structure JSON invalide")
            return nil
        }
        
        return jsonArray
    }
    
    
    
    
    
    static private func obtenirInformationsAttractions() async throws -> [[String: Any]] {
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
        
        let json = try await requêteHTTP(url: url, méthode: .post, élémentsEntête: [], corps: corps)
        
        return parserInformationsAttractionsJSON(json: json) ?? [[:]]
    }
    
    
    static private func parserInformationsAttractionsJSON(json: Any) -> [[String: Any]]? {
        guard let jsonDict = json as? [String: Any],
              let dataSection = jsonDict["data"] as? [String: Any],
              let attractions = dataSection["Attraction"] as? [[String: Any]] else {
            print("Structure JSON invalide")
            return nil
        }
        
        return attractions
    }
    
    
    
    
    // MARK: Fonctions envoie requête
    
    static private func requêteHTTP(url: String, méthode: MéthodeHTTP, élémentsEntête: [ElementEntete], corps: [String: Any]? = nil) async throws -> Any {
        // Création de la requête avec les entêtes et le corps
        let requête = try formerRequête(url: url, méthode: méthode, élémentsHeader: élémentsEntête, corps: corps)
        
        // Envoie de la requête et récupération des résultats
        do {
            let (données, réponse) = try await URLSession.shared.data(for: requête)
            
            // Récupération du contenu de la réponse
            guard let réponse = réponse as? HTTPURLResponse else {
                throw NSError()
            }
            let codeStatut = réponse.statusCode
            //let entêtes = réponse.allHeaderFields
            
            print(codeStatut)
            
            // Décodage de la réponse JSON
            let json = try JSONSerialization.jsonObject(with: données, options: [])
            
            return json
            
        } catch {
            if let erreurURL = error as? URLError {
                if erreurURL.code == .notConnectedToInternet {
                    throw NSError()
                }
            }
            throw error
        }
    }
    
    
    
    static private func formerRequête(url: String, méthode: MéthodeHTTP, élémentsHeader: [ElementEntete], corps: [String: Any]?) throws -> URLRequest {
        guard let url = URL(string: url) else {
            throw NSError()
        }
        
        var requête = URLRequest(url: url)
        requête.httpMethod = méthode.rawValue
        
        // Ajout des éléments dans l'entête
        for élément in élémentsHeader {
            requête.addValue(élément.contenu, forHTTPHeaderField: élément.champs)
        }
        
        // Ajout du cours s'il s'agit d'une méthode POST
        if méthode == .post, let corps = corps {
            do {
                let donnéesCorps = try JSONSerialization.data(withJSONObject: corps, options: [])
                requête.httpBody = donnéesCorps
                if donnéesCorps.count > 0 {
                    requête.addValue("\(donnéesCorps.count)", forHTTPHeaderField: "Content-Length")
                }
            } catch {
                
            }
        }
        
        return requête
    }
}
