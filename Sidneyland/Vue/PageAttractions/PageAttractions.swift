//
//  PageAttractions.swift
//  Sidneyland
//
//  Created by Thomas Le Bonnec on 29/09/2025.
//

import SwiftUI

struct PageAttractions: View {
    
    // MARK: Attributs
    
    @Namespace var namespace: Namespace.ID
    @Environment(\.changerOnglet) var changerOnglet
    @EnvironmentObject var gestionnaire: GestionnaireAttractions
    
    
    
    // MARK: Init
    
    init() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        appearance.titleTextAttributes = [
            .font: UIFont(name: "MontserratRoman-Bold", size: 18)!,
            .foregroundColor: UIColor.white
        ]
        appearance.largeTitleTextAttributes = [
            .font: UIFont(name: "MontserratRoman-Bold", size: 28)!,
            .foregroundColor: UIColor.white
        ]
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
    }
    
    
    
    // MARK: Vue
    
    var body: some View {
        NavigationStack {
            FondImageFloue(image: "Chateau") {
                ScrollView {
                    contenu
                }
                .scrollIndicators(.hidden)
            }
            .navigationTitle("Disneyland")
            .toolbar {
                ToolbarSpacer(placement: .bottomBar)
                
                ToolbarItem(placement: .bottomBar) {
                    Button {
                        changerOnglet(.carte)
                    } label: {
                        HStack {
                            Image(systemName: "map.fill")
                            Text("Carte")
                                .font(.corps)
                        }
                    }
                }
            }
        }
    }
    
    //"Bloquer la preview"
    
    var contenu: some View {
        LazyVStack(spacing: 42) {
            SectionCompteARebours()
                .padding(.horizontal, 8)
            
            SectionAttractions(namespace: namespace, symbole: "map.fill", titre: "Autour de moi", attractions: gestionnaire.attractions.filter{$0.univers == .adventureland})
                .conteneuriserSectionAttractions(true)
            
            SectionAttractions(namespace: namespace, symbole: "heart.fill", titre: "Favoris", attractions: gestionnaire.attractions.filter{$0.estFavorite == true})
                .style(.rangs)
                .nbRangsSectionAttractions(2)
                .pageDetailSectionAvecFavoris(false)    // Celui-ci semble n'avoir aucun effet
            
            cartesGroupes
            
            CartoucheGlossaire()
                .padding()
        }
        //.padding(.top, 32)
        .padding(.top, 16)
    }
    
    
    var cartesGroupes: some View {
        LazyVGrid(columns: [GridItem(.flexible(), spacing: 16), GridItem(.flexible(), spacing: 16)], alignment: .center, spacing: 16) {
            CarteGroupe(namespace: namespace, titre: "Frontierland", image: "BTM",
                        attractions: gestionnaire.attractions.filter{$0.univers == .frontierland})
            
            CarteGroupe(namespace: namespace, titre: "Adventureland", image: "Cabane Robinson",
                        attractions: gestionnaire.attractions.filter{$0.univers == .adventureland})
            
            CarteGroupe(namespace: namespace, titre: "Discoveryland", image: "Space Mountain",
                        attractions: gestionnaire.attractions.filter{$0.univers == .discoveryland})
            
            CarteGroupe(namespace: namespace, titre: "Fantasyland", image: "Les Tasses",
                        attractions: gestionnaire.attractions.filter{$0.univers == .fantasyland})
            
            CarteGroupe(namespace: namespace, titre: "Disney Studio", image: "HTH",
                        attractions: gestionnaire.attractions.filter{$0.parc == .studio})
            
            CarteGroupe(namespace: namespace, titre: "Toutes les attractions", image: "Chateau",
                        attractions: gestionnaire.attractions)
            .pageDetailSectionAvecFavoris(false)
        }
        .padding()
    }
}





#Preview {
    @Previewable @StateObject var appVM: GestionnaireAttractions = .init()
    
    PageAttractions()
        .environmentObject(appVM)
}
