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
    var attractions: [Attraction]
    
    private let columns = [
        GridItem(.adaptive(minimum: 150, maximum: 200), spacing: 20, alignment: .top)
    ]
    
    
    
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
            FondPrincipal {
                ScrollView {
                    contenu
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
    
    
    var contenu: some View {
        LazyVGrid(columns: columns, spacing: 20) {
            ForEach(attractions, id: \.id) { attraction in
                CarteAttraction(namespace: namespace, attraction: attraction, largeurLibre: true)
            }
        }
        .padding()
        .padding(.top, 24)
        .padding(.bottom, 8)
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
    
    return FondPrincipal {
        PageDetailSection(namespace: namespace, titre: "Favoris", attractions: attractions)
    }
}
