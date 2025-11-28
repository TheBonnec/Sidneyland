//
//  ServiceHTTP.swift
//  Sidneyland
//
//  Created by Thomas Le Bonnec on 24/11/2025.
//

import Foundation


class ServiceHTTP {
    static func requêteHTTP(url: String, méthode: MéthodeHTTP, élémentsEntête: [ElementEntete], corps: [String: Any]? = nil) async throws -> Data {
        // Création de la requête avec les entêtes et le corps
        let requête = try formerRequête(url: url, méthode: méthode, élémentsHeader: élémentsEntête, corps: corps)
        
        // Envoie de la requête et récupération des résultats
        do {
            let (données, réponse) = try await URLSession.shared.data(for: requête)
            
            // Récupération du contenu de la réponse
            guard let réponse = réponse as? HTTPURLResponse else {
                throw NSError()
            }
            //let codeStatut = réponse.statusCode
            //let entêtes = réponse.allHeaderFields
            
            // Décodage de la réponse JSON
            //let json = try JSONSerialization.jsonObject(with: données, options: [])
            //print(json)
            
            return données
            
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




struct ElementEntete : Sendable {
    let champs: String
    let contenu: String
}


enum MéthodeHTTP: String, Sendable {
    case get = "GET"
    case post = "POST"
}
