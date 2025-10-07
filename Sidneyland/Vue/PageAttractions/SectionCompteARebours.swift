//
//  SectionCompteARebours.swift
//  Sidneyland
//
//  Created by Thomas Le Bonnec on 07/10/2025.
//

import SwiftUI

struct SectionCompteARebours: View {
    
    // MARK: Vue
    
    var body: some View {
        VStack(spacing: 24) {
            Text(tempsRestant)
                .font(.grosTitre)
            
            let pourcentage = min(pourcentageRestant, 1.0)
            HStack(spacing: 16) {
                ProgressView(value: pourcentage, total: 1.0)
                    .progressViewStyle(LinearProgressViewStyle(tint: .purple))
                    .frame(maxWidth: .infinity)
                
                Text("\(String(format: "%.3f", pourcentage * 100)) %")
                    .font(.corpsImportant)
            }
        }
        .padding(.horizontal, 32)
        .padding(.vertical, 24)
        .foregroundStyle(Color.white)
        .background(Color.white.opacity(0.16))
        .bordureArrondie(rayon: 32)
        .shadow(color: .black.opacity(0.12), radius: 16)
    }
    
    
    
    // MARK: Propriétés Calculées
    
    var tempsRestant: String {
        let calendar = Calendar.current

        let today = Date()

        var components = DateComponents()
        components.year = 2025
        components.month = 11
        components.day = 29

        if let targetDate = calendar.date(from: components) {
            let diff = calendar.dateComponents([.day], from: today, to: targetDate).day!
            return diff < 0 ? "J + \(diff * -1)" : "J - \(diff)"
        }
        return "Erreur"
    }
    
    
    var pourcentageRestant: Double {
        let startDate = Date(timeIntervalSince1970: 1758126600)
        let endDate = Date(timeIntervalSince1970: 1764351000)
        let now = Date()
        
        // Si la fin est avant le début -> 0% par sécurité
        guard endDate > startDate else { return 0 }
        
        let totalDuration = endDate.timeIntervalSince(startDate)
        let elapsed = now.timeIntervalSince(startDate)
        
        // Clamp la valeur entre 0 et 1
        let ratio = max(0, min(1, elapsed / totalDuration))
        
        return ratio // retourne en pourcentage (0–100)
    }
}





#Preview {
    FondImageFloue {
        SectionCompteARebours()
    }
}
