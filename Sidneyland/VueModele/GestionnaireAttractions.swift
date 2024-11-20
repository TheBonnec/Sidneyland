//
//  GestionnaireAttractions.swift
//  Sidneyland
//
//  Created by Thomas Le Bonnec on 19/11/2024.
//

import Foundation


class GestionnaireAttractions {
    
    static func obtenirDonnéesAttractions() async throws -> [Attraction] {
        let donnéesBruts = try await APIDisneyland.obtenirDonnéesBrutsAttractions()
        var toutesAttractions = RegistreAttractions.attractions()
        
        for i in 0..<toutesAttractions.count {
            let attraction = toutesAttractions[i]
            let informations = trouverAttraction(dans: donnéesBruts.informations, avecID: attraction.id, pourClé: "id")
            let état = trouverAttraction(dans: donnéesBruts.états, avecID: attraction.id, pourClé: "entityId")
            let informationsAttraction = listesVersInformationsAttraction(informations: informations, état: état)
            
            toutesAttractions[i].modifierInformation(informationsAttraction)
        }
        
        return toutesAttractions
    }
    
    
    
    
    
    static private func trouverAttraction(dans liste: [[String: Any]], avecID: String, pourClé clé: String) -> [String: Any]? {
        guard liste.isEmpty == false else { return nil }
        
        return liste.first { élément in
            if let id = élément[clé] as? String {
                return id == avecID
            }
            return false
        }
    }
    
    
    
    static private func listesVersInformationsAttraction(informations: [String: Any]?, état: [String: Any]?) -> InformationsAttraction {
        // Valeur par défaut avant assignation
        var tempsAttente = 0
        var tempsSingleRider: Int? = nil
        var fonctionnement: FonctionnementAttraction = .inconnu
        var attractionEstOuverte: Bool = true
        
        
        if let informations {
            if let horaires = informations["schedules"] as? [[String: Any]], !horaires.isEmpty {
                if let fonctionnementBrut = horaires[0]["status"] as? String {
                    // Indique si l'attraction est disponible ou en travaux
                    if fonctionnementBrut == "REFURBISHMENT" {
                        fonctionnement = .enTravaux
                    }
                }
                
                let horaireOuvertue = horaires[0]["startTime"] as? String ?? ""
                let horaireFermeture = horaires[0]["endTime"] as? String ?? ""
                attractionEstOuverte = estDansIntervalle(date: Date(), debut: horaireOuvertue, fin: horaireFermeture)
            }
        }
        
        if let état {
            if let tempsAttenteStr = état["postedWaitMinutes"] as? String {
                tempsAttente = Int(tempsAttenteStr) ?? 0
            }
            
            if let singleRider = état["singleRider"] as? [String: Any] {
                tempsSingleRider = singleRider["singleRiderWaitMinutes"] as? Int
            }
            
            if let fonctionnementBrut = état["status"] as? String, fonctionnement != .enTravaux {
                // Indique l'état de fonctionnement de l'attraction
                switch fonctionnementBrut {
                case "OPERATING": fonctionnement = .enMarche
                case "REFURBISHMENT": fonctionnement = .fermée
                case "DOWN": fonctionnement = .enPanne
                default: fonctionnement = .inconnu
                }
            }
        } else if !attractionEstOuverte {
            fonctionnement = .fermée
        }
        
        
        let informationsAttraction = InformationsAttraction(
            tempsAttente: tempsAttente,
            tempsSingleRider: tempsSingleRider,
            fonctionnement: fonctionnement
        )
        
        return informationsAttraction
    }
    
    
    
    
    
    static private func estDansIntervalle(date: Date, debut: String, fin: String) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone.current
        
        // Extraire l'heure de l'objet Date donné
        let calendrier = Calendar.current
        let composantesDate = calendrier.dateComponents([.hour, .minute, .second], from: date)
        guard let heureActuelle = dateFormatter.date(from: String(format: "%02d:%02d:%02d",
                                                                  composantesDate.hour ?? 0,
                                                                  composantesDate.minute ?? 0,
                                                                  composantesDate.second ?? 0)) else {
            return true     // Par défaut l'attraction est ouverte
        }
        
        // Convertir les horaires de début et de fin en Date
        guard let heureDebut = dateFormatter.date(from: debut),
              let heureFin = dateFormatter.date(from: fin) else {
            return true     // Par défaut l'attraction est ouverte
        }
        
        // Comparer l'heure avec l'intervalle
        if heureDebut <= heureActuelle && heureActuelle <= heureFin {
            return true
        } else {
            return false
        }
    }
    
}
