//
//  ContentView.swift
//  Sidneyland
//
//  Created by Thomas Le Bonnec on 15/09/2024.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: Attributs
    
    @Namespace private var animationRangAttraction
    
    @EnvironmentObject var tailleÉcran: TailleEcran
    @EnvironmentObject var appVM: AppVM
    @EnvironmentObject var détailAttractionVM: DetailAttractionVM
    @EnvironmentObject var sélectionOnglet: SelectionOnglet
    
    @State var onglet: Onglet = .pagePrincipale
    
    
    
    // MARK: Init
    
    init() {
        UITabBar.appearance().scrollEdgeAppearance = UITabBarAppearance.init()
    }
    
    
    
    // MARK: Vue
    
    var body: some View {
        Group {
            if onglet == .pagePrincipale {
                PageAttractions()
                    .transition(.move(edge: .leading))
            } else if onglet == .carte {
                PageCarte()
                    .transition(.move(edge: .trailing))
            }
        }
        .actionChangerOnglet { onglet in
            withAnimation(.smooth(duration: 0.3)) {
                self.onglet = onglet
            }
        }
        
        
        /*
        GeometryReader { géometrie in
            ZStack {
                vueOnglets
                
                if détailAttractionVM.détailEstAffiché {
                    vueDétails
                }
            }
            
            .onAppear {
                self.tailleÉcran.configurerTaille(taille: géometrie.frame(in: .global), safeArea: géometrie.safeAreaInsets)
            }
            .onChange(of: géometrie.frame(in: .global)) { avant, après in
                // Si l'écran est tourné (iOS), ou que la fenêtre est redimensionnée (macOS)
                self.tailleÉcran.configurerTaille(taille: après, safeArea: géometrie.safeAreaInsets)
            }
        }*/
    }
    
    
    
    var vueOnglets: some View {
        TabView(selection: $sélectionOnglet.sélection) {
            LazyView(PagePrincipale(namespace: animationRangAttraction, favorisUniquement: false))
                .tabItem {
                    Label("Attractions", systemImage: "mountain.2.fill")
                }
                .tag(0)
            
            LazyView(PagePrincipale(namespace: animationRangAttraction, favorisUniquement: true))
                .tabItem {
                    Label("Favoris", systemImage: "heart.fill")
                }
                .tag(1)
            
            LazyView(PageCarte())
                .tabItem {
                    Label("Carte", systemImage: "map")
                }
                .tag(2)
        }
    }
    
    
    var vueDétails: some View {
        Group {
            if let attraction = détailAttractionVM.attractionSélectionnée {
                Color.clear
                    .overlay {
                        PageDetailAttraction(namespace: animationRangAttraction, attraction: attraction)
                    }
                    .ignoresSafeArea()
                    .zIndex(3)
                    .transition(.modale)
            } else {
                vueErreur
            }
        }
    }
    
    
    var vueErreur: some View {
        Button {
            détailAttractionVM.fermerDétail()
        } label: {
            VStack(alignment: .center, spacing: 16) {
                Image(systemName: "questionmark")
                    .font(.sousTitre)
                    .foregroundStyle(Color.gray)
                
                Text("Une erreur est survenue\nAppuyez pour revenir")
                    .font(.corps)
                    .padding()
                    .foregroundStyle(Color.white)
                    .background(Color.purple)
                    .bordureArrondie(rayon: 8)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
    }
}




extension AnyTransition {
    static var identityHack: AnyTransition {
        .asymmetric(insertion: .identity, removal: .identity)
    }
}





#Preview {
    ContentView()
        .environmentObject(TailleEcran())
        .environmentObject(AppVM())
        .environmentObject(DetailAttractionVM())
        .environmentObject(SelectionOnglet())
}
