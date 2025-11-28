//
//  RegistrePoints.swift
//  Sidneyland
//
//  Created by Thomas Le Bonnec on 28/11/2025.
//

import Foundation

class RegistrePoints {
    static func points() -> [PointPassage] {
        var points: [PointPassage] = []
        
        // Main Street USA
        points.append(PointPassage(id: "1M1", type: .passage, position: CGPoint(x: 48.870130, y: 2.779989)))     // Entrée du Parc
        points.append(PointPassage(id: "1M2", type: .passage, position: CGPoint(x: 48.872012, y: 2.777545)))     // Entrée Central Plaza
        
        points.append(PointPassage(id: "1MA", type: .attraction(id: "P1MA01"), position: CGPoint(x: 48.870832, y: 2.778803)))        // Gare MainStreet
        
        
        // Frontierland
        points.append(PointPassage(id: "1R1", type: .passage, position: CGPoint(x: 48.871979, y: 2.776406)))     // Fort
        points.append(PointPassage(id: "1R2", type: .passage, position: CGPoint(x: 48.871728, y: 2.774182)))     // 1e passage Adventureland
        points.append(PointPassage(id: "1R3", type: .passage, position: CGPoint(x: 48.871550, y: 2.773646)))     // 2e passage Adventureland
        
        points.append(PointPassage(id: "1RA", type: .attraction(id: "P1RA00"), position: CGPoint(x: 48.871548, y: 2.774807)))    // BTM
        points.append(PointPassage(id: "1RB", type: .attraction(id: "P1RA03"), position: CGPoint(x: 48.870954, y: 2.776819)))    // Phantom Manor
        points.append(PointPassage(id: "1RC", type: .attraction(id: "P1RA06"), position: CGPoint(x: 48.871193, y: 2.776526)))    // TMRL
        points.append(PointPassage(id: "1RD", type: .attraction(id: "P1RA10"), position: CGPoint(x: 48.870280, y: 2.772369)))    // Gare
        
        
        // Adventureland
        points.append(PointPassage(id: "1A1", type: .passage, position: CGPoint(x: 48.872587, y: 2.775518)))     // Passage Aladin
        points.append(PointPassage(id: "1A2", type: .passage, position: CGPoint(x: 48.872144, y: 2.775528)))     // Passage à coté Aladin
        points.append(PointPassage(id: "1A3", type: .passage, position: CGPoint(x: 48.873400, y: 2.774042)))     // 1e passage Fantasyland
        points.append(PointPassage(id: "1A4", type: .passage, position: CGPoint(x: 48.873515, y: 2.773831)))     // 2e passage Fantasyland
        
        points.append(PointPassage(id: "1AA", type: .attraction(id: "P1AA02"), position: CGPoint(x: 48.872425, y: 2.772068)))    // Indiana Jones
        points.append(PointPassage(id: "1AB", type: .attraction(id: "P1AA04"), position: CGPoint(x: 48.873478, y: 2.773412)))    // Pirates des caraibes
        points.append(PointPassage(id: "1AC", type: .attraction(id: "P1AA01"), position: CGPoint(x: 48.872488, y: 2.773844)))    // Cabane Robinson
        points.append(PointPassage(id: "1AD", type: .attraction(id: "P1AA00"), position: CGPoint(x: 48.872714, y: 2.773530)))    // Adventure Isle
        points.append(PointPassage(id: "1AE", type: .attraction(id: "P1AA03"), position: CGPoint(x: 48.872654, y: 2.775282)))    // Aladin
        
        
        // Fantasyland
        points.append(PointPassage(id: "1F1", type: .passage, position: CGPoint(x: 48.872906, y: 2.775606)))     // Derière tanière
        points.append(PointPassage(id: "1F2", type: .passage, position: CGPoint(x: 48.873097, y: 2.776143)))     // Chateau
        points.append(PointPassage(id: "1F3", type: .passage, position: CGPoint(x: 48.873861, y: 2.776859)))     // Proche Discoveryland
        
        points.append(PointPassage(id: "1FA", type: .attraction(id: "P1NA07"), position: CGPoint(x: 48.874701, y: 2.776127)))    // Maison poupées
        points.append(PointPassage(id: "1FB", type: .attraction(id: "P1NA09"), position: CGPoint(x: 48.875163, y: 2.774472)))    // Contes de fées
        points.append(PointPassage(id: "1FC", type: .attraction(id: "P1NA03"), position: CGPoint(x: 48.875122, y: 2.774187)))    // Train cirque
        points.append(PointPassage(id: "1FD", type: .attraction(id: "P1NA00"), position: CGPoint(x: 48.874542, y: 2.774555)))    // Alice
        points.append(PointPassage(id: "1FE", type: .attraction(id: "P1NA08"), position: CGPoint(x: 48.874343, y: 2.774984)))    // Les tasses
        points.append(PointPassage(id: "1FF", type: .attraction(id: "P1NA02"), position: CGPoint(x: 48.873942, y: 2.775121)))    // Lancelot
        points.append(PointPassage(id: "1FG", type: .attraction(id: "P1NA01"), position: CGPoint(x: 48.873480, y: 2.775520)))    // Blanche neige
        points.append(PointPassage(id: "1FH", type: .attraction(id: "P1NA13"), position: CGPoint(x: 48.873605, y: 2.775123)))    // Pinocchio
        points.append(PointPassage(id: "1FI", type: .attraction(id: "P1NA05"), position: CGPoint(x: 48.874187, y: 2.774665)))    // Dumbo
        points.append(PointPassage(id: "1FJ", type: .attraction(id: "P1NA10"), position: CGPoint(x: 48.873849, y: 2.774112)))    // Peter pan
        points.append(PointPassage(id: "1FK", type: .attraction(id: "P1NA16"), position: CGPoint(x: 48.874355, y: 2.773922)))    // Gare
        points.append(PointPassage(id: "1FL", type: .attraction(id: "P1NA12"), position: CGPoint(x: 48.873014, y: 2.775869)))    // Dragon
        
        
        // Discoveryland
        points.append(PointPassage(id: "1D1", type: .passage, position: CGPoint(x: 48.873085, y: 2.777757)))     // Central Plaza
        points.append(PointPassage(id: "1D2", type: .passage, position: CGPoint(x: 48.874866, y: 2.777599)))     // Passage Fantasyland
        
        points.append(PointPassage(id: "1DA", type: .attraction(id: "P1DA08"), position: CGPoint(x: 48.873656, y: 2.778828)))    // Space Mountain
        points.append(PointPassage(id: "1DB", type: .attraction(id: "P1DA09"), position: CGPoint(x: 48.874792, y: 2.778978)))    // Star Tour
        points.append(PointPassage(id: "1DC", type: .attraction(id: "P1DA03"), position: CGPoint(x: 48.873459, y: 2.778820)))    // Autopia
        points.append(PointPassage(id: "1DD", type: .attraction(id: "P1DA04"), position: CGPoint(x: 48.873439, y: 2.777996)))    // Buzz l'éclair
        points.append(PointPassage(id: "1DE", type: .attraction(id: "P1DA07"), position: CGPoint(x: 48.873457, y: 2.778382)))    // Orbitron
        points.append(PointPassage(id: "1DF", type: .attraction(id: "P1DA06"), position: CGPoint(x: 48.873423, y: 2.779528)))    // Nautilus
        points.append(PointPassage(id: "1DG", type: .attraction(id: "P1DA10"), position: CGPoint(x: 48.874612, y: 2.778793)))    // Gare
        
        
        
        // World Premiere
        points.append(PointPassage(id: "2W1", type: .passage, position: CGPoint(x: 48.868337, y: 2.780837)))     // Entrée du parc
        
        points.append(PointPassage(id: "2WA", type: .attraction(id: "P2ZA02"), position: CGPoint(x: 48.866797, y: 2.778806)))    // HTH
        
        
        // Avengers Campus
        points.append(PointPassage(id: "2A1", type: .passage, position: CGPoint(x: 48.866225, y: 2.779654)))     // À coté HTH
        points.append(PointPassage(id: "2A2", type: .passage, position: CGPoint(x: 48.866379, y: 2.778221)))     // Derière HTH
        
        points.append(PointPassage(id: "2AA", type: .attraction(id: "P2AC01"), position: CGPoint(x: 48.865306, y: 2.779402)))    // Flight Force
        points.append(PointPassage(id: "2AB", type: .attraction(id: "P2AC02"), position: CGPoint(x: 48.865982, y: 2.779576)))    // Spider man
        
        
        // World of Pixar
        points.append(PointPassage(id: "2P1", type: .passage, position: CGPoint(x: 48.867855, y: 2.778503)))     // En face Crush Coaster
        points.append(PointPassage(id: "2P2", type: .passage, position: CGPoint(x: 48.867171, y: 2.777851)))     // Derière parachutes
        
        points.append(PointPassage(id: "2PA", type: .attraction(id: "P2XA03"), position: CGPoint(x: 48.868037, y: 2.778200)))    // Crush Coaster
        points.append(PointPassage(id: "2PB", type: .attraction(id: "P2XA09"), position: CGPoint(x: 48.867545, y: 2.776239)))    // Ratatouille
        points.append(PointPassage(id: "2PC", type: .attraction(id: "P2XA00"), position: CGPoint(x: 48.866585, y: 2.774732)))    // Cars
        points.append(PointPassage(id: "2PD", type: .attraction(id: "P2XA06"), position: CGPoint(x: 48.866917, y: 2.776524)))    // RC Racer
        points.append(PointPassage(id: "2PE", type: .attraction(id: "P2XA08"), position: CGPoint(x: 48.867134, y: 2.776971)))    // Zigzag
        points.append(PointPassage(id: "2PF", type: .attraction(id: "P2XA07"), position: CGPoint(x: 48.867180, y: 2.777229)))    // Parachutes
        
        
        return points
    }
}
