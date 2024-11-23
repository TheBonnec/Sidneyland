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
    //@EnvironmentObject var appVM: AppVM
    
    var attraction: Attraction
    var actionFermeture: () -> Void
    
    @State private var vueChargée = false
    
    
    
    // MARK: Init
    
    init(namespace: Namespace.ID, attraction: Attraction, actionFermeture: @escaping () -> Void) {
        self.namespace = namespace
        self.attraction = attraction
        self.actionFermeture = actionFermeture
    }
    
    
    
    // MARK: Vue
    
    var body: some View {
        ZStack {
            imageFond
            VStack {
                Spacer()
                contenu
            }
            boutonFermeture
        }
        .onAppear {
            withAnimation(.spring(duration: 0.3, bounce: 0.2)) {
                vueChargée = true
            }
        }
        .onDisappear() {
            withAnimation(.spring(duration: 0.2, bounce: 0.2)) {
                vueChargée = false
            }
        }
    }
    
    
    
    var imageFond: some View {
        VStack {
            Image(attraction.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .matchedGeometryEffect(id: "Image-\(attraction.id)", in: namespace)
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .mask {
            RoundedRectangle(cornerRadius: 0, style: .continuous)
                .matchedGeometryEffect(id: "MasqueImage-\(attraction.id)", in: namespace)
        }
        .ignoresSafeArea()
    }
    
    
    
    var contenu: some View {
        ZStack {
            FlouTransparent(tailleFlou: 32)
                .ignoresSafeArea()
            
            VStack(spacing: 24) {
                Text(attraction.nom)
                    .font(.gigaTitre)
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(Color.white)
                    .multilineTextAlignment(.center)
                    
                
                BarreInformationsAttraction(informations: attraction.informations, couleur: attraction.couleur)
            }
            .padding()
        }
        .fixedSize(horizontal: false, vertical: true)
        .offset(y: vueChargée ? 0 : 300)
    }
    
    
    var boutonFermeture: some View {
        HStack {
            VStack {
                Button(action: actionFermeture) {
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
            }
            
            Spacer()
        }
    }
}







#Preview {
    @Previewable @StateObject var appVM = AppVM()
    @Previewable @Namespace var animationRangAttraction
    
    
    let informations = InformationsAttraction(
        tempsAttente: 15,
        tempsSingleRider: 5,
        horaireFermeture: Date(),
        fonctionnement: .enMarche
    )
    
    var attraction = Attraction(
        id: "P0AA00",
        nom: "Big Thunder Mountain",
        image: "BTM",
        couleur: "#3E2500",
        parc: .disneyland,
        univers: .frontierland
    )
    
    attraction.modifierInformation(informations)
    
    return PageDetailAttraction(namespace: animationRangAttraction, attraction: attraction) {
        print("")
    }
    .environmentObject(appVM)
}
