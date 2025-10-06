//
//  PageDetailSection.swift
//  Sidneyland
//
//  Created by Thomas Le Bonnec on 30/09/2025.
//

import SwiftUI

struct PageDetailSection: View {
    
    // MARK: Attributs
    
    var namespace: Namespace.ID
    var titre: String
    var image: String
    var avecFavoris: Bool
    var attractions: [Attraction]
    
    
    
    // MARK: Init
    
    init(namespace: Namespace.ID, titre: String, image: String = "Chateau", avecFavoris: Bool = true, attractions: [Attraction]) {
        self.namespace = namespace
        self.titre = titre
        self.image = image
        self.avecFavoris = avecFavoris
        self.attractions = attractions
        
        
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
            FondPrincipal(image: image) {
                ScrollView {
                    VStack(spacing: 16) {
                        if avecFavoris {
                            listeFavoris
                        }
                        listeAttractions
                    }
                    .padding(.top, 16)
                    .padding(.bottom, 8)
                }
            }
            .navigationTitle(titre)
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
    
    
    var listeFavoris: some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing: 20) {
                ForEach(attractions.filter { $0.estFavorite == true }, id: \.id) { attraction in
                    CarteAttraction(namespace: namespace, attraction: attraction)
                }
            }
            .scrollTargetLayout()
        }
        .scrollTargetBehavior(.viewAligned)
        .scrollIndicators(.hidden)
        .scrollClipDisabled()
        .padding()
    }
    
    
    var listeAttractions: some View {
        LazyVStack(spacing: 16) {
            ForEach(attractions, id: \.id) { attraction in
                RangAttraction2(namespace: namespace, attraction: attraction)
            }
        }
        .padding()
    }
}





#Preview {
    @Previewable @Namespace var namespace
    
    let attractions = RegistreAttractions.attractions().filter { $0.estFavorite == true }
    for i in 0...attractions.count - 1 {
        attractions[i].modifierInformation(InformationsAttraction(
            tempsAttente: 5 * (i + 1),
            tempsSingleRider: nil,
            horaireFermeture: Date(),
            fonctionnement: i == 2 ? .fermée : .enMarche
        ))
    }
    
    return PageDetailSection(namespace: namespace, titre: "Favoris", image: "BTM", attractions: attractions)
}
