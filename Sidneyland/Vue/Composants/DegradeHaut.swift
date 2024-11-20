//
//  DegradeHaut.swift
//  Sidneyland
//
//  Created by Thomas Le Bonnec on 19/11/2024.
//

import SwiftUI

struct DegradeHaut: View {
    
    // MARK: Attributs
    
    var largeurÉcran: CGFloat
    var hauteurSafeArea: CGFloat
    var déplacement: CGFloat
    
    
    
    // MARK: Vue
    
    var body: some View {
        VStack(spacing: 0) {
            Color.clear
                .frame(width: largeurÉcran, height: hauteurSafeArea)
                .background(.ultraThinMaterial)
            
            Spacer()
        }
        .ignoresSafeArea()
        .opacity(opacitéDégradéHaut(hauteurSafeArea: hauteurSafeArea, déplacement: déplacement))
    }
    
    
    
    // MARK: Méthodes
    
    func opacitéDégradéHaut(hauteurSafeArea: CGFloat, déplacement: CGFloat) -> Double {
        let déplacementDécalé = -(déplacement + 200 - hauteurSafeArea)
        let déplacementPositif = max(0, déplacementDécalé)
        let déplacementPlafonné = min(hauteurSafeArea, déplacementPositif)
        let opacité = déplacementPlafonné / 50
        return opacité
    }
}
