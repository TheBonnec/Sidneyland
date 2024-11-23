//
//  PagePrincipale.swift
//  Sidneyland
//
//  Created by Thomas Le Bonnec on 19/11/2024.
//

import SwiftUI

struct PagePrincipale: View {
    
    // MARK: Attributs
    
    var namespace: Namespace.ID
    
    @EnvironmentObject var appVM: AppVM
    
    
    
    // MARK: Vue
    
    var body: some View {
        PatronPagePrincipale() {
            if !appVM.chargement {
                vueAttractions
            } else {
                vueChargement
            }
        } actionRafraichissement: {
            appVM.raffraichirDonnéesAttractions()
        }
    }
    
    
    
    var vueAttractions: some View {
        LazyVStack(spacing: 24) {
            ForEach(appVM.attractions) { attraction in
                RangAttraction(namespace: namespace, attraction: attraction)
                    .onTapGesture {
                        appVM.ouvrirDétail(attraction: attraction)
                    }
            }
            
            CartoucheGlossaire()
        }
        .padding(16)
    }
    
    
    
    var vueChargement: some View {
        VStack(spacing: 24) {
            ForEach((1...14), id: \.self) { attraction in
                SqueletteRangAttraction()
            }
        }
        .padding(16)
    }
}





#Preview {
    @Previewable @Namespace var animationRangAttraction
    
    PagePrincipale(namespace: animationRangAttraction)
        .environmentObject(AppVM())
        .environmentObject(TailleEcran())
}
