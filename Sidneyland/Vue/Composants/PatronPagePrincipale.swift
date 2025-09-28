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
    private var avecCompteÀRebours: Bool
    
    @State var défilement: CGFloat = 0
    
    // Constantes
    let arrondi: CGFloat = 24
    
    
    
    // MARK: Init
    
    init(compteÀRebours: Bool = false, @ViewBuilder contenu: () -> Contenu) {
        self.contenu = contenu()
        self.avecDéfilement = false
        self.actionRafraichissement = {}
        self.avecCompteÀRebours = compteÀRebours
    }
    
    init(compteÀRebours: Bool = false, @ViewBuilder contenu: () -> Contenu, actionRafraichissement: @escaping () -> Void) {
        self.contenu = contenu()
        self.actionRafraichissement = actionRafraichissement
        self.avecDéfilement = true
        self.avecCompteÀRebours = compteÀRebours
    }
    
    
    
    // MARK: Vue
    
    var body: some View {
        ZStack {
            if avecDéfilement {
                DegradeHaut(largeurÉcran: tailleÉcran.largeur, hauteurSafeArea: tailleÉcran.safeAreaHaut, défilement: défilement)
                .zIndex(80)
            }
            
            
            // Illustration
            if défilement >= -210 {                 // Marge de 10 (200 normalement)
                VStack(alignment: .center) {
                    GeometryReader { geo in
                        let défilementPositif = max(0, défilement)
                        
                        ZStack {
                            Image("Chateau Principal")
                                .resizable()
                                .scaledToFill()
                            
                            if avecCompteÀRebours {
                                compteÀRebours
                            }
                        }
                        .frame(width: geo.frame(in: .global).width + défilementPositif, height: 224 + défilementPositif)
                            .offset(x: -défilementPositif / 2)
                            .clipped()
                        // Utilisé pour masquer le bas de l'image, et éviter que la transparence du contenu lors de transition ne l'affiche
                            .mask {
                                ZStack {
                                    Rectangle()
                                    if défilement <= 0 {
                                        RoundedRectangle(cornerRadius: 24)
                                            .foregroundStyle(Color.fondPrimaire)
                                            .frame(height: 48 - défilement)
                                            .offset(y: 112 + défilement / 2)
                                            .blendMode(.destinationOut)
                                    }
                                }
                            }
                    }
                    
                    Spacer()
                }
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
    
    
    var compteÀRebours: some View {
        VStack(spacing: 12) {
            Text(tempsRestant)
                .font(.gigaTitre)
            
            /*
            let pourcentage = min(pourcentageRestant, 1.0)
            HStack {
                ProgressView(value: pourcentage, total: 1.0)
                    .progressViewStyle(LinearProgressViewStyle(tint: .purple))
                    .frame(maxWidth: 100)
                
                Text("\(String(format: "%.3f", pourcentage * 100)) %")
                    .font(.corpsImportant)
            }
             */
        }
        .padding()
        .padding(.horizontal)
        .background(.ultraThinMaterial)
        .bordureArrondie(rayon: 24)
        .shadow(color: .black.opacity(0.12), radius: 16)
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
                        .onChange(of: géometrie.frame(in: .global).minY) { avant, après in
                            self.défilement = après
                        }
                })
        }
        .refreshable {
            actionRafraichissement()
        }
    }
    
    
    
    // MARK: Propriétés Calculées
    
    var tempsRestant: String {
        let calendar = Calendar.current

        let today = Date()

        var components = DateComponents()
        components.year = 2025
        components.month = 11
        components.day = 29

        if let targetDate = calendar.date(from: components) {
            let diff = calendar.dateComponents([.day], from: today, to: targetDate).day!
            return diff < 0 ? "J + \(diff * -1)" : "J - \(diff)"
        }
        return "Erreur"
    }
    
    
    var pourcentageRestant: Double {
        let startDate = Date(timeIntervalSince1970: 1758126600)
        let endDate = Date(timeIntervalSince1970: 1764351000)
        let now = Date()
        
        // Si la fin est avant le début -> 0% par sécurité
        guard endDate > startDate else { return 0 }
        
        let totalDuration = endDate.timeIntervalSince(startDate)
        let elapsed = now.timeIntervalSince(startDate)
        
        // Clamp la valeur entre 0 et 1
        let ratio = max(0, min(1, elapsed / totalDuration))
        
        return ratio // retourne en pourcentage (0–100)
    }
}





#Preview {
    let tailleÉcran = TailleEcran()
    tailleÉcran.largeur = 402
    tailleÉcran.hauteur = 874
    tailleÉcran.safeAreaHaut = 50
    
    return PatronPagePrincipale() {
        Text("Hello, World!")
    }
    .environmentObject(tailleÉcran)
}
