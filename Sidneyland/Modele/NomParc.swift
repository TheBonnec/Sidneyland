//
//  NomParc.swift
//  Sidneyland
//
//  Created by Thomas Le Bonnec on 15/09/2024.
//

import Foundation


enum NomParc: String {
    case disneyland = "Disneyland Park"
    case studio = "Walt Disney Studios"
    
    
    var symbole: String {
        switch self {
        case .disneyland: return "Symbole Disneyland Park"
        case .studio: return "Symbole Walt Disney Studio"
        }
    }
}
