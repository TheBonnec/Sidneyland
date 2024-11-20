//
//  ContentView.swift
//  Sidneyland
//
//  Created by Thomas Le Bonnec on 15/09/2024.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: Attributs
    
    @EnvironmentObject var tailleÉcran: TailleEcran
    @StateObject var appVM = ContentViewVM()
    
    
    
    // MARK: Vue
    
    var body: some View {
        GeometryReader { géometrie in
            PagePrincipale(appVM: appVM)
                .onAppear {
                    self.tailleÉcran.configurerTaille(taille: géometrie.frame(in: .global), safeAreaTop: géometrie.safeAreaInsets.top)
                }
                .onChange(of: géometrie.frame(in: .global)) { valeur in
                    self.tailleÉcran.configurerTaille(taille: valeur, safeAreaTop: géometrie.safeAreaInsets.top)   // Si l'écran est tourné (iOS), ou que la fenêtre est redimensionnée (macOS)
                }
        }
    }
}

#Preview {
    ContentView()
}
