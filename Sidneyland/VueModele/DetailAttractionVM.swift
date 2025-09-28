//
//  DetailAttractionVM.swift
//  Sidneyland
//
//  Created by Thomas Le Bonnec on 28/11/2024.
//

import SwiftUI

class DetailAttractionVM: ObservableObject {
    
    // MARK: Attributs
    
    @Published var attractionSélectionnée: Attraction?
    @Published var détailEstAffiché: Bool = false
    
    
    
    // MARK: Méthodes
    
    func ouvrirDétail(attraction: Attraction) {
        if attractionSélectionnée == nil {
            withAnimation(.ressort) {
                attractionSélectionnée = attraction
                self.détailEstAffiché = true
            }
        }
    }
    
    
    func fermerDétail() {
        withAnimation(.ressortRapide) {
            détailEstAffiché = false
        }
        
        DispatchQueue.main.async {
            withAnimation(.ressortRapide) {
                self.attractionSélectionnée = nil
            }
        }
    }
}
