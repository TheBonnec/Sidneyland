//
//  FondPrincipal.swift
//  Sidneyland
//
//  Created by Thomas Le Bonnec on 29/09/2025.
//

import SwiftUI

struct FondPrincipal<Contenu: View>: View {
    
    // MARK: Attributs
    
    @Environment(\.colorScheme) var modeLumière
    let image: String
    let contenu: Contenu
    
    
    
    // MARK: Init
    
    init(image: String = "Chateau", contenu: () -> Contenu) {
        self.image = image
        self.contenu = contenu()
    }
    
    
    
    // MARK: Vue
    
    var body: some View {
        ZStack {
            Image(image)
                .resizable()
                .scaledToFill()
                .frame(minWidth: 0, maxWidth: .infinity)
                .ignoresSafeArea()
            
            Rectangle()
                .fill(.thinMaterial)
                .ignoresSafeArea()
            
            couleurFond
                .ignoresSafeArea()
            
            contenu
        }
    }
    
    
    
    // MARK: Propriétés Calculés
    
    var couleurFond: Color {
        if modeLumière == .dark {
            return .black.opacity(0.7)
        }
        return .black.opacity(0.76)
    }
}





#Preview {
    FondPrincipal(image: "Chateau") {
        Text("Bonjour")
    }
}
