//
//  PageCarte.swift
//  Sidneyland
//
//  Created by Thomas Le Bonnec on 25/11/2024.
//

import SwiftUI

struct PageCarte: View {
    
    // MARK: Attributs
    
    @Environment(\.changerOnglet) var changerOnglet
    
    @EnvironmentObject var gestionnaire: GestionnaireAttractions
    
    @State var décalage = CGSize.zero
    @State var dernierDécalage = CGSize.zero
    @State var agrandissement: CGFloat = 1
    @State var dernierAgrandissement: CGFloat = 1
    @State var centreAgrandissement: CGPoint?
    
    @AppStorage("carteAvecFavorisUniquement") var favorisUniquement: Bool = false
    
    let largeurImage: Double = 7680
    let hauteurImage: Double = 8192
    let ratioImage: Double = 7680 / 8192
    
    
    
    
    // MARK: Vue
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.fondCarte
                    .ignoresSafeArea()
                
                
                GeometryReader { géometrie in
                    Image("Carte Parc")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                        .scaleEffect(agrandissement)
                        .offset(décalage)
                        .overlay {
                            TissuCarte(largeurImage: largeurImage, hauteurImage: hauteurImage, décalage: $décalage, agrandissement: $agrandissement, favorisUniquement: $favorisUniquement)
                        }
                        .gesture(
                            DragGesture()
                                .onChanged { valeur in
                                    décalage = CGSize(
                                        width: dernierDécalage.width + valeur.translation.width,
                                        height: dernierDécalage.height + valeur.translation.height
                                    )
                                }
                                .onEnded { valeur in
                                    withAnimation() {
                                        décalage = calculerDécalageLimité(
                                            tentativeDécalage: décalage,
                                            tailleÉcran: géometrie.size
                                        )
                                        dernierDécalage = décalage
                                    }
                                }
                        )
                        .gesture(
                            MagnifyGesture()
                                .onChanged { valeur in
                                    agrandissement = dernierAgrandissement * valeur.magnification
                                    
                                    décalage = calculerDécalagePourAgrandissement(
                                        tailleÉcran: géometrie.size,
                                        pointToucher: valeur.startLocation,
                                        agrandissement: valeur.magnification,
                                        décalage: dernierDécalage
                                    )
                                }
                                .onEnded { valeur in
                                    withAnimation() {
                                        let agrandissementAdapté = calculerAgrandissementLimité(
                                            tentativeAgrandissement: agrandissement
                                        )
                                        
                                        if agrandissement != agrandissementAdapté {
                                            // Ajustement du décalage par rapport à la limitation de l'agrandissement
                                            décalage = calculerDécalagePourAgrandissement(
                                                tailleÉcran: géometrie.size,
                                                pointToucher: valeur.startLocation,
                                                agrandissement: agrandissementAdapté / agrandissement,
                                                décalage: décalage
                                            )
                                        }
                                        
                                        agrandissement = agrandissementAdapté
                                        dernierAgrandissement = agrandissement
                                        
                                        // Ajustement délage en cas de dépassement
                                        décalage = calculerDécalageLimité(
                                            tentativeDécalage: décalage,
                                            tailleÉcran: géometrie.size
                                        )
                                        dernierDécalage = décalage
                                        
                                        centreAgrandissement = nil
                                    }
                                }
                        )
                }
                .ignoresSafeArea()
                
                
                vueBoutons
            }
        }
    }
    
    
    var vueBoutons: some View {
        Color.clear
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    Button {
                        gestionnaire.raffraichirDonnéesAttractions()
                    } label: {
                        Image(systemName: "arrow.clockwise")
                    }
                }
                ToolbarItem(placement: .bottomBar) {
                    Button {
                        favorisUniquement.toggle()
                    } label: {
                        Image(systemName: favorisUniquement ? "heart.fill" : "heart")
                    }
                }
                
                ToolbarSpacer(.flexible, placement: .bottomBar)
                
                ToolbarItem(placement: .bottomBar) {
                    Button {
                        changerOnglet(.pagePrincipale)
                    } label: {
                        HStack {
                            Image(systemName: "rectangle.fill.on.rectangle.angled.fill")
                            
                            Text("Attractions")
                                .font(.description)
                        }
                    }
                }
            }
    }
    
    
    
    // MARK: Méthodes
    
    func calculerTailleImage(tailleÉcran: CGSize) -> CGSize {
        let ratioÉcran = tailleÉcran.width / tailleÉcran.height
        
        if ratioImage > ratioÉcran {
            // L'image est limitée par sa hauteur
            let hauteur = tailleÉcran.height * agrandissement
            let largeur = hauteur * ratioImage
            return CGSize(width: largeur, height: hauteur)
        } else {
            // L'image est limitée par sa largeur
            let largeur = tailleÉcran.width * agrandissement
            let hauteur = largeur / ratioImage
            return CGSize(width: largeur, height: hauteur)
        }
    }
    
    
    func calculerDécalageLimité(tentativeDécalage: CGSize, tailleÉcran: CGSize) -> CGSize {
        let tailleImage = calculerTailleImage(tailleÉcran: tailleÉcran)
        
        let largeurLimite = max(0, (tailleImage.width - tailleÉcran.width) / 2)
        let hauteurLimite = max(0, (tailleImage.height - tailleÉcran.height) / 2)
        
        let décalageX = min(largeurLimite, max(-largeurLimite, tentativeDécalage.width))
        let décalageY = min(hauteurLimite, max(-hauteurLimite, tentativeDécalage.height))
        
        return CGSize(width: décalageX, height: décalageY)
    }
    
    
    func calculerAgrandissementLimité(tentativeAgrandissement: CGFloat) -> CGFloat {
        return min(8, max(1, tentativeAgrandissement))
    }
    
    
    func calculerDécalagePourAgrandissement(tailleÉcran: CGSize, pointToucher: CGPoint, agrandissement: CGFloat, décalage: CGSize) -> CGSize {
        // Position du toucher par rapport au centre de l'image
        let pointToucherImage = CGPoint(
            x: pointToucher.x - tailleÉcran.width / 2 - décalage.width,
            y: pointToucher.y - tailleÉcran.height / 2 - décalage.height
        )
        
        // Ajustement du décalage pour maintenir le point sous le doigt
        return CGSize(
            width: décalage.width - pointToucherImage.x * (agrandissement - 1),
            height: décalage.height - pointToucherImage.y * (agrandissement - 1)
        )
    }
}




#Preview {
    PageCarte()
        .environmentObject(GestionnaireAttractions())
}

