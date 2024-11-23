//
//  SqueletteRangAttraction.swift
//  Sidneyland
//
//  Created by Thomas Le Bonnec on 20/11/2024.
//

import SwiftUI

struct SqueletteRangAttraction: View {
    
    // MARK: Attributs
    
    @Environment(\.colorScheme) var colorScheme
    
    
    
    // MARK: Vue
    
    var body: some View {
        HStack(spacing: 16) {
            Rectangle()
                .frame(width: 60, height: 60)
                .foregroundStyle(Color.noir.opacity(opacitéPrincipale()))
                .bordureArrondie(rayon: 8)
            
            VStack(alignment: .leading, spacing: 6) {
                Rectangle()
                    .frame(width: 170, height: 16)
                    .foregroundStyle(Color.noir.opacity(opacitéPrincipale()))
                    .bordureArrondie(rayon: 4)
                
                Rectangle()
                    .frame(width: 120, height: 14)
                    .foregroundStyle(Color.noir.opacity(opacitéSecondaire()))
                    .bordureArrondie(rayon: 4)
            }
            
            Spacer()
            
            Rectangle()
                .frame(width: 50, height: 60)
                .foregroundStyle(Color.noir.opacity(opacitéSecondaire()))
                .bordureArrondie(rayon: 8)
        }
    }
    
    
    
    // MARK: Méthodes
    
    func opacitéPrincipale() -> Double {
        if colorScheme == .dark {
            return 0.2
        }
        return 0.1
    }
    
    func opacitéSecondaire() -> Double {
        if colorScheme == .dark {
            return 0.14
        }
        return 0.07
    }
}





#Preview {
    SqueletteRangAttraction()
}
