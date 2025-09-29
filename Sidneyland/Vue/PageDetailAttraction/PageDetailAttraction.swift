//
//  PageDetailAttraction.swift
//  Sidneyland
//
//  Created by Thomas Le Bonnec on 20/11/2024.
//

import SwiftUI

struct PageDetailAttraction: View {
    
    // MARK: Attributs
    
    var namespace: Namespace.ID
    var attraction: Attraction
    
    @Environment(\.progressionTransitionModale) var progression
    @EnvironmentObject var détailAttractionVM: DetailAttractionVM
    @EnvironmentObject var tailleÉcran: TailleEcran
    @EnvironmentObject var sélectionOnglet: SelectionOnglet
    
    @State private var vueChargée = false
    
    
    
    // MARK: Init
    
    init(namespace: Namespace.ID, attraction: Attraction) {
        self.namespace = namespace
        self.attraction = attraction
    }
    
    
    
    // MARK: Vue
    
    var body: some View {
        
        let tailleImage = CGSize(
            width: tailleÉcran.largeur,
            height: tailleÉcran.hauteur
        )
        
        // Différence entre l'image de détail et la vignette
        let différence = CGSize(
            width: tailleImage.width - 60,
            height: tailleImage.height - 60
        )
        
        let w = 60 + différence.width * progression
        let h = 60 + différence.height * progression
        
        
        return ZStack {
            imageFond(w: w, h: h)
            
            VStack {
                Spacer()
                contenu
            }
            .zIndex(3)
            
            boutons
        }
        .onAppear {
            withAnimation(.ressort) {
                vueChargée = true
            }
        }
        .onDisappear {
            //TODO: Mettre en place une méthode avec 2 MGE() par vue pour faire en sorte qu'une soit utilisée quand la seconde n'a pas terminée
            /*
            détailAttractionVM.attractionSélectionnée = nil
            print("Disparu")
            */
        }
        // En cas de bug, la vue peut ne pas avoir été complètement fermée avant d'être réouverte. Puisqu'elle n'est jamais vraiment fermé en cas de bug, elle peut donc detecter les changement détailAttractionVM.détailEstAffiché,
        .onChange(of: détailAttractionVM.détailEstAffiché) { oldValue, newValue in
            withAnimation(.ressort) {
                vueChargée = newValue
            }
        }
    }
    
    
    
    @ViewBuilder
    func imageFond(w: CGFloat, h: CGFloat) -> some View {
        Color.clear
            .overlay {
                Image(attraction.image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: w, height: h + progression)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .clipped()
                    .zIndex(2)
            }
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .contentShape(RoundedRectangle(cornerRadius: 8))
            .frame(width: w, height: h + progression)
            .matchedGeometryEffect(id: "\(attraction.id)-P\(sélectionOnglet.sélection)", in: namespace, properties: .frame)
    }
    
    
    
    var contenu: some View {
        ZStack {
            FlouTransparent(tailleFlou: 32)
                .ignoresSafeArea()
            
            VStack(spacing: 24) {
                Text(attraction.nom)
                    .font(.grosTitre)
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(Color.white)
                    .multilineTextAlignment(.center)
                    
                
                BarreInformationsAttraction(informations: attraction.informations, couleur: attraction.couleur)
            }
            .padding()
        }
        .fixedSize(horizontal: false, vertical: true)
        .offset(y: vueChargée ? -tailleÉcran.safeAreaBas : 300)
    }
    
    
    var boutons: some View {
        VStack {
            HStack {
                Button {
                    détailAttractionVM.fermerDétail()
                    withAnimation(.ressortRapide) {
                        vueChargée = false
                    }
                } label: {
                    Image(systemName: "xmark")
                        .font(.information)
                        .foregroundColor(.purple)
                        .padding(12)
                        .background(Color.white)
                        .clipShape(Circle())
                        .shadow(color: .black.opacity(0.1), radius: 8)
                }
                .padding()
                
                Spacer()
                
                
                BoutonFavori(attraction: attraction)
                
            }
            
            Spacer()
        }
        .offset(y: vueChargée ? tailleÉcran.safeAreaHaut : -300)
        .zIndex(3)
    }
}







#Preview {
    @Previewable @StateObject var détailAttractionVM = DetailAttractionVM()
    @Previewable @Namespace var animationRangAttraction
    
    
    let informations = InformationsAttraction(
        tempsAttente: 15,
        tempsSingleRider: 5,
        horaireFermeture: Date(),
        fonctionnement: .enMarche
    )
    
    let attraction = Attraction(
        id: "P0AA00",
        nom: "Big Thunder Mountain",
        image: "BTM",
        couleur: "#3E2500",
        parc: .disneyland,
        univers: .frontierland
    )
    
    attraction.modifierInformation(informations)
    
    return PageDetailAttraction(namespace: animationRangAttraction, attraction: attraction)
        .environmentObject(détailAttractionVM)
        .environmentObject(TailleEcran())
        .environmentObject(SelectionOnglet())
}
