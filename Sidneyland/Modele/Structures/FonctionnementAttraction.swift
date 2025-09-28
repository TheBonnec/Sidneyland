//
//  FonctionnementAttraction.swift
//  Sidneyland
//
//  Created by Thomas Le Bonnec on 16/11/2024.
//

import Foundation


enum FonctionnementAttraction {
    case enMarche, enPanne, fermée, enTravaux, inconnu
    
    var image: String {
        switch self {
        case .enMarche: return "checkmark"
        case .enPanne: return "exclamationmark.triangle.fill"
        case .fermée: return "xmark.octagon.fill"
        case .enTravaux: return "wrench.and.screwdriver.fill"
        case .inconnu: return "questionmark"
        }
    }
    
    var description: String {
        switch self {
        case .enMarche: return "Attraction en marche"
        case .enPanne: return "Attraction en panne"
        case .fermée: return "Attraction fermée"
        case .enTravaux: return "Attraction en travaux"
        case .inconnu: return "Aucune info sur l'attraction"
        }
    }
}
