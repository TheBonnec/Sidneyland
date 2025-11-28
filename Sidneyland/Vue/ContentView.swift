//
//  ContentView.swift
//  Sidneyland
//
//  Created by Thomas Le Bonnec on 15/09/2024.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: Attributs
    
    @Namespace private var animationRangAttraction
    @EnvironmentObject var gestionnaire: GestionnaireAttractions
    
    @State var onglet: Onglet = .pagePrincipale
    @State var détailAttraction: Attraction? = nil
    
    
    
    // MARK: Init
    
    init() {
        UITabBar.appearance().scrollEdgeAppearance = UITabBarAppearance.init()
    }
    
    
    
    // MARK: Vue
    
    var body: some View {
        Group {
            if onglet == .pagePrincipale {
                PageAttractions()
                    .transition(.move(edge: .leading))
            } else if onglet == .carte {
                PageCarte()
                    .transition(.move(edge: .trailing))
            }
        }
        .sheet(item: $détailAttraction) { attraction in
            PageDetailAttraction(namespace: animationRangAttraction, attraction: attraction)
                .presentationDragIndicator(.visible)
        }
        .actionChangerOnglet { onglet in
            withAnimation(.smooth(duration: 0.3)) {
                self.onglet = onglet
            }
        }
        .actionOuvrirDétailAttraction { attraction in
            self.détailAttraction = attraction
        }
    }
}




extension AnyTransition {
    static var identityHack: AnyTransition {
        .asymmetric(insertion: .identity, removal: .identity)
    }
}





#Preview {
    ContentView()
        .environmentObject(GestionnaireAttractions())
}
