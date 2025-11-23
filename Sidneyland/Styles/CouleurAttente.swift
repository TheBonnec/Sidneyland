//
//  CouleurAttente.swift
//  Sidneyland
//
//  Created by Thomas Le Bonnec on 22/11/2025.
//

import SwiftUI

extension Int {
    var couleurAttente: Color {
        if self <= 15 {
            return .vert
        } else if self <= 30 {
            return .jaune
        } else if self <= 60 {
            return .mandarine
        }
        return .rouge
    }
}
