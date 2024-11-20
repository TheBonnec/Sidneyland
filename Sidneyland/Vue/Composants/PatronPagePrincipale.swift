//
//  PatronPagePrincipale.swift
//  Sidneyland
//
//  Created by Thomas Le Bonnec on 19/11/2024.
//

import SwiftUI

struct PatronPagePrincipale<Contenu: View>: View {
    
    // MARK: Attributs
    
    @EnvironmentObject var tailleÉcran: TailleEcran
    
    var contenu: Contenu
    var actionRafraichissement: () -> Void
    private var avecDéfilement: Bool
    
    @State var déplacement: CGFloat = 0
    
    // Constantes
    let arrondi: CGFloat = 24
    
    
    
    // MARK: Init
    
    init(@ViewBuilder contenu: () -> Contenu) {
        self.contenu = contenu()
        self.avecDéfilement = false
        self.actionRafraichissement = {}
    }
    
    init(@ViewBuilder contenu: () -> Contenu, actionRafraichissement: @escaping () -> Void) {
        self.contenu = contenu()
        self.actionRafraichissement = actionRafraichissement
        self.avecDéfilement = true
    }
    
    
    
    // MARK: Vue
    
    var body: some View {
        ZStack {
            if avecDéfilement {
            DegradeHaut(largeurÉcran: tailleÉcran.largeur, hauteurSafeArea: tailleÉcran.safeAreaTop, déplacement: déplacement)
                .zIndex(80)
            }
            
            
            // Illustration
            VStack(alignment: .center) {
                GeometryReader { geo in
                    let déplacementPositif = max(0, déplacement)
                    
                    Image("Chateau Principal")
                        .resizable()
                        .scaledToFill()
                        .frame(width: geo.frame(in: .global).width + déplacementPositif, height: 224 + déplacementPositif)
                        .offset(x: -déplacementPositif / 2)
                        .clipped()
                }
                
                Spacer()
            }
                
            
            if avecDéfilement {
                contenuAvecDéfilement
            } else {
                contenuFixe
            }
        }
        .ignoresSafeArea(edges: .top)
        .background(Color.fondPrimaire)
    }
    
    
    var contenuFixe: some View {
        contenu
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Color.fondPrimaire
                    .bordureArrondie(rayon: arrondi)
                    .shadow(color: .black.opacity(0.20), radius: 16)    // Pour avoir une ombre seulement en haut de la carte
                    .mask(Rectangle().bordureArrondie(rayon: arrondi).padding(.top, -32))
            )
            .padding(.top, 200)
    }
    
    
    var contenuAvecDéfilement: some View {
        ScrollView(showsIndicators: false) {
            contenu
                .padding(.top, 2)
                .background(
                    Color.fondPrimaire
                        .bordureArrondie(rayon: arrondi)
                        .shadow(color: .black.opacity(0.20), radius: 16)    // Pour avoir une ombre seulement en haut de la carte
                        .mask(Rectangle().bordureArrondie(rayon: arrondi).padding(.top, -32))
                )
                .padding(.top, 200)
            
            
                // Déplacement la ScrollView
                .background(GeometryReader { géometrie in
                    Color.clear
                        .onChange(of: géometrie.frame(in: .global).minY) { valeur in
                            self.déplacement = valeur
                        }
                })
        }
        .refreshable {
            actionRafraichissement()
        }
    }
}





#Preview {
    var tailleÉcran = TailleEcran()
    tailleÉcran.largeur = 402
    tailleÉcran.hauteur = 874
    tailleÉcran.safeAreaTop = 50
    
    return PatronPagePrincipale {
        Text("Hello, World!")
    }
    .environmentObject(tailleÉcran)
}
