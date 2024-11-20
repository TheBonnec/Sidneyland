//
//  PagePrincipale.swift
//  Sidneyland
//
//  Created by Thomas Le Bonnec on 19/11/2024.
//

import SwiftUI

struct PagePrincipale: View {
    
    // MARK: Attributs
    
    @ObservedObject var appVM: ContentViewVM
    
    
    
    // MARK: Vue
    
    var body: some View {
        PatronPagePrincipale {
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
        VStack(spacing: 24) {
            ForEach(appVM.attractions) { attraction in
                RangAttraction(attraction: attraction)
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
    PagePrincipale(appVM: ContentViewVM())
        .environmentObject(TailleEcran())
}
