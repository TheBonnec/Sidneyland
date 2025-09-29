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
    var favorisUniquement: Bool
    
    @EnvironmentObject var tailleÉcran: TailleEcran
    @EnvironmentObject var appVM: AppVM
    @EnvironmentObject var détailAttractionVM: DetailAttractionVM
    @EnvironmentObject var sélectionOnglet: SelectionOnglet
    
    @State var hauteurVue: CGFloat = 0
    
    
    
    // MARK: Vue
    
    var body: some View {
        PatronPagePrincipale(compteÀRebours: !favorisUniquement) {
            if !appVM.chargement {
                if !favorisUniquement && sélectionOnglet.sélection == 0 {
                    vueAttractions
                } else if favorisUniquement && sélectionOnglet.sélection == 1 {
                    vueAttractionsFavorites
                } else {
                    Color.clear
                        .frame(width: tailleÉcran.largeur - tailleÉcran.safeAreaGauche - tailleÉcran.safeAreaDroite - 16, height: hauteurVue)
                }
            } else {
                vueChargement
            }
        } actionRafraichissement: {
            appVM.raffraichirDonnéesAttractions()
        }
    }
    
    
    
    var vueAttractions: some View {
        VStack(spacing: 24) {
            ForEach(appVM.attractions, id: \.id) { attraction in
                RangAttraction(namespace: namespace, attraction: attraction)
                    .onTapGesture {
                        détailAttractionVM.ouvrirDétail(attraction: attraction)
                    }
            }
            
            CartoucheGlossaire()
        }
        .padding(16)
        .background(
            GeometryReader { géometrie in
                Color.clear
                    .onAppear {
                        hauteurVue = géometrie.size.height
                    }
                    .onChange(of: géometrie.size.height) { ancienneHautre, nouvelleHauteur in
                        hauteurVue = nouvelleHauteur
                    }
            }
        )
    }
    
    
    
    var vueAttractionsFavorites: some View {
        VStack(spacing: 24) {
            if !appVM.idAttractionsFavorites.isEmpty {
                ForEach(appVM.attractions, id: \.id) { attraction in
                    if attraction.estFavorite {
                        RangAttraction(namespace: namespace, attraction: attraction)
                            .onTapGesture {
                                détailAttractionVM.ouvrirDétail(attraction: attraction)
                            }
                    }
                }
            } else {
                vueFavorisVide
            }
            
            CartoucheGlossaire()
        }
        .padding(16)
        .background(
            GeometryReader { géometrie in
                Color.clear
                    .onAppear {
                        hauteurVue = géometrie.size.height
                    }
                    .onChange(of: géometrie.size.height) { ancienneHautre, nouvelleHauteur in
                        hauteurVue = nouvelleHauteur
                    }
            }
        )
        .background {
            if !appVM.idAttractionsFavorites.isEmpty {
                ForEach(appVM.attractions, id: \.id) { attraction in
                    if !attraction.estFavorite {
                        RangAttraction(namespace: namespace, attraction: attraction)
                    }
                }
                .frame(height: 0)
                .opacity(0.0)
                .offset(y: hauteurVue + 400)
            }
        }
    }
    
    
    
    var vueFavorisVide: some View {
        VStack {
            Text("Ajoutez des attractions favorites en appuyant sur le bouton cœur sur la page d'une attraction.")
                .font(.description)
                .foregroundStyle(Color.gray)
                .multilineTextAlignment(.center)
                .padding()
            
            BoutonFavori(attraction: Attraction(id: "Essai", nom: "", image: "", parc: .disneyland, univers: .adventureland))
        }
        .frame(height: 400)
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
    
    PagePrincipale(namespace: animationRangAttraction, favorisUniquement: true)
        .environmentObject(AppVM())
        .environmentObject(TailleEcran())
        .environmentObject(DetailAttractionVM())
        .environmentObject(SelectionOnglet())
}
