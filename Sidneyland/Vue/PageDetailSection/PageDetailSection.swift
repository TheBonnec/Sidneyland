//
//  PageDetailSection.swift
//  Sidneyland
//
//  Created by Thomas Le Bonnec on 30/09/2025.
//

import SwiftUI

struct PageDetailSection: View {
    
    // MARK: Attributs
    
    @Environment(\.pageDetailSectionAvecFavoris) var avecFavoris
    @Environment(\.imagePageDetailSection) var image
    
    var namespace: Namespace.ID
    var titre: String
    var attractions: [Attraction]
    
    
    
    // MARK: Init
    
    init(namespace: Namespace.ID, titre: String, attractions: [Attraction]) {
        self.namespace = namespace
        self.titre = titre
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
        .onAppear {
            print("onAppear - page détail : \(avecFavoris)")
        }
        .onChange(of: avecFavoris) { oldValue, newValue in
            print("onChange - page détail : \(newValue)")
        }
    }
    
    
    var listeFavoris: some View {
        SectionAttractions(namespace: namespace, attractions: attractions.filter{ $0.estFavorite })
            .afficherTitreSectionAttractions(false)
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
    
    return PageDetailSection(namespace: namespace, titre: "Favoris", attractions: attractions)
        .imagePageDetailSection("BTM")
}
