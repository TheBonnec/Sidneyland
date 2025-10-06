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
    @EnvironmentObject var appVM: AppVM
    
    
    
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
            FondPrincipal(image: "Chateau") {
                ScrollView {
                    contenu
                }
                .scrollIndicators(.hidden)
            }
            .navigationTitle("Disneyland")
            .toolbar {
                ToolbarSpacer(.flexible, placement: .bottomBar)
                
                ToolbarItem(placement: .bottomBar) {
                    Button {
                        print("")
                    } label: {
                        HStack {
                            Image(systemName: "map")
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
            SectionAttractions(namespace: namespace, symbole: "map.fill", titre: "Autour de moi", conteneurisé: true, attractions: appVM.attractions.filter{$0.univers == .adventureland})
            SectionAttractions(namespace: namespace, symbole: "heart.fill", titre: "Favoris", attractions: appVM.attractions.filter{$0.estFavorite == true}, nbRangs: 2, enRangs: true, détailAvecFavoris: false)
            
            cartesGroupes
            
            CartoucheGlossaire()
                .padding()
        }
        .padding(.top, 32)
    }
    
    
    var cartesGroupes: some View {
        LazyVGrid(columns: [GridItem(.flexible(), spacing: 16), GridItem(.flexible(), spacing: 16)], alignment: .center, spacing: 16) {
            CarteGroupe(namespace: namespace, titre: "Frontierland", image: "BTM",
                        attractions: appVM.attractions.filter{$0.univers == .frontierland})
            
            CarteGroupe(namespace: namespace, titre: "Adventureland", image: "Cabane Robinson",
                        attractions: appVM.attractions.filter{$0.univers == .adventureland})
            
            CarteGroupe(namespace: namespace, titre: "Discoveryland", image: "Space Mountain",
                        attractions: appVM.attractions.filter{$0.univers == .discoveryland})
            
            CarteGroupe(namespace: namespace, titre: "Fantasyland", image: "Maison Poupees",
                        attractions: appVM.attractions.filter{$0.univers == .fantasyland})
            
            CarteGroupe(namespace: namespace, titre: "Disney Studio", image: "HTH",
                        attractions: appVM.attractions.filter{$0.parc == .studio})
            
            CarteGroupe(namespace: namespace, titre: "Toutes les attractions", image: "Chateau",
                        attractions: appVM.attractions)
        }
        .padding()
    }
}





#Preview {
    @Previewable @StateObject var appVM: AppVM = .init()
    
    PageAttractions()
        .environmentObject(appVM)
}
