//
//  Route.swift
//  Sidneyland
//
//  Created by Thomas Le Bonnec on 28/11/2025.
//

import Foundation

class Route: Identifiable {
    var id = UUID()
    var départ: PointPassage
    var arrivé: PointPassage
    var distance: Float         // En mètres
    var durée: Float            // En secondes
    
    
    init(id: UUID = UUID(), départ: PointPassage, arrivé: PointPassage, distance: Float, durée: Float) {
        self.id = id
        self.départ = départ
        self.arrivé = arrivé
        self.distance = distance
        self.durée = durée
    }
}
