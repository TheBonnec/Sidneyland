//
//  PointPassage.swift
//  Sidneyland
//
//  Created by Thomas Le Bonnec on 28/11/2025.
//

import Foundation


class PointPassage: Identifiable {
    var id: String
    var type: TypePoint
    var position: CGPoint
    
    
    init(id: String, type: TypePoint, position: CGPoint) {
        self.id = id
        self.type = type
        self.position = position
    }
    
    
    enum TypePoint {
        case passage
        case attraction(id: String)
    }
}
