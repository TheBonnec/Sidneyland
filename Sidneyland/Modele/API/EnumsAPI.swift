//
//  EnumsAPI.swift
//  Sidneyland
//
//  Created by Thomas Le Bonnec on 16/11/2024.
//

import Foundation


struct ElementEntete : Sendable {
    let champs: String
    let contenu: String
}


enum MéthodeHTTP: String, Sendable {
    case get = "GET"
    case post = "POST"
}
