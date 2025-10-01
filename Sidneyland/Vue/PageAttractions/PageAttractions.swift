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
                .scrollTargetBehavior(.viewAligned)
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
            SectionAttractions(namespace: namespace, symbole: "heart.fill", titre: "Favoris", attractions: appVM.attractions.filter{$0.estFavorite == true}, nbRangs: 2)
            
            SectionAttractions(namespace: namespace, titre: "Frontierland", attractions: appVM.attractions.filter{$0.univers == .frontierland})
            SectionAttractions(namespace: namespace, titre: "Adventureland", attractions: appVM.attractions.filter{$0.univers == .adventureland})
            SectionAttractions(namespace: namespace, titre: "Discoveryland", attractions: appVM.attractions.filter{$0.univers == .discoveryland})
            SectionAttractions(namespace: namespace, titre: "Fantasyland", attractions: appVM.attractions.filter{$0.univers == .fantasyland})
            SectionAttractions(namespace: namespace, titre: "Disney Studio", attractions: appVM.attractions.filter{$0.parc == .studio})
            
            CartoucheGlossaire()
                .padding()
        }
        .padding(.top, 32)
        .scrollTargetLayout()
    }
}





#Preview {
    @Previewable @StateObject var appVM: AppVM = .init()
    
    PageAttractions()
        .environmentObject(appVM)
}
