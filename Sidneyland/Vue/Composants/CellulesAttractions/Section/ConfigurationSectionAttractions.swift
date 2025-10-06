//
//  ConfigurationSectionAttractions.swift
//  Sidneyland
//
//  Created by Thomas Le Bonnec on 06/10/2025.
//

import SwiftUI

struct ConfigurationSectionAttractions {
    let id = UUID()
    let namespace: Namespace.ID
    let symbole: String?
    let titre: String?
    let attractions: [Attraction]
}
