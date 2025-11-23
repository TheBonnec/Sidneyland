//
//  CarteAttraction.swift
//  Sidneyland
//
//  Created by Thomas Le Bonnec on 28/09/2025.
//

import SwiftUI

struct CarteAttraction: View {
    
    // MARK: Attributs
    
    var namespace: Namespace.ID
    var attraction: Attraction
    var largeurLibre: Bool = false
    
    @State var afficherDétail = false
    
    // Dimensions
    let écartementIndicateurBord: CGFloat = 8.0
    let décallageFavoris: CGFloat = 4.25
    let dimensionsFavoris: CGFloat = 34     // C'est un rond parfait
    let dimensionsImage: CGSize = .init(width: 150, height: 240)
    let arrondiImage: CGFloat = 24
    let borduresHorizontalesVueTitre: CGFloat = 4
    
    
    
    // MARK: Vue
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            vueImage
            
            if attraction.estFavorite {
                badgeFavoris
                    .offset(x: décallageFavoris, y: -décallageFavoris)
            }
        }
        .frame(height: dimensionsImage.height)
        .frame(maxWidth: largeurLibre ? .infinity : dimensionsImage.width)
        .frame(minWidth: dimensionsImage.width)
        .contentShape(Rectangle())
        .onTapGesture {
            afficherDétail = true
        }
        .sheet(isPresented: $afficherDétail) {
            PageDetailAttraction2(namespace: namespace, attraction: attraction)
                .presentationDragIndicator(.visible)
        }
    }
    
    
    var vueImage: some View {
        GeometryReader { geo in
            VStack {
                Spacer()
                
                vueTitre
                    .padding(.horizontal, 14)
                    .padding(.bottom, écartementIndicateurBord)
                    .padding(.top, 20)
                    .background {
                        VariableBlurView(maxBlurRadius: 16)
                    }
            }
            .background {
                Image(attraction.image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: geo.size.width, height: geo.size.height)
                    .clipped()
            }
            .bordureArrondie(rayon: arrondiImage)
        }
    }
    
    
    var badgeFavoris: some View {
        Image(systemName: "heart.fill")
            .foregroundStyle(Color.white)
            .frame(width: dimensionsFavoris, height: dimensionsFavoris)
            .background(Rectangle().fill(.ultraThinMaterial))
            .bordureArrondie(rayon: 1000)
    }
    
    
    var vueTitre: some View {
        VStack(spacing: écartementIndicateurBord) {
            Text(attraction.nomCourt ?? attraction.nom)
                .font(.descriptionImportante)
                .foregroundStyle(Color.white)
                .lineLimit(2)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)
                .truncationMode(.tail)
            
            IndicateurAttente(tempsAttente: attraction.informations?.tempsAttente ?? 0, fonctionnement: attraction.informations?.fonctionnement ?? .inconnu)
        }
    }
}





#Preview {
    @Previewable @Namespace var animationRangAttraction
    
    let attraction = Attraction(
        id: "P0AA00",
        nom: "Big Thunder Mountain",
        image: "BTM",
        parc: .disneyland,
        univers: .frontierland
    )
    
    attraction.estFavorite = true
    
    attraction.modifierInformation(InformationsAttraction(
        tempsAttente: 45,
        tempsSingleRider: 5,
        horaireFermeture: Date(),
        fonctionnement: .enMarche
    ))
    
    return FondImageFloue {
        CarteAttraction(namespace: animationRangAttraction, attraction: attraction)
    }
}
