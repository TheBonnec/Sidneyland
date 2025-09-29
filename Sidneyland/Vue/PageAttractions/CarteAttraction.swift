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
    
    // Dimensions
    let écartTexteImage: CGFloat = 12
    let décallageFavoris: CGFloat = 4.25
    let dimensionsFavoris: CGFloat = 34     // C'est rond parfait
    let dimensionsImage: CGSize = .init(width: 150, height: 225)
    let arrondiImage: CGFloat = 24
    let borduresHorizontalesVueTitre: CGFloat = 4
    
    
    
    // MARK: Vue
    
    var body: some View {
        VStack(alignment: .leading, spacing: écartTexteImage) {
            // Zone Image
            ZStack(alignment: .topTrailing) {
                vueImage
                
                if attraction.estFavorite {
                    badgeFavoris
                        .offset(x: décallageFavoris, y: -décallageFavoris)
                }
            }
            .frame(height: dimensionsImage.height)
            
            //vueTitre
        }
        .frame(width: dimensionsImage.width)
    }
    
    
    var vueImage: some View {
        GeometryReader { geo in
            VStack {
                Spacer()
                
                vueTitre
                    .padding([.horizontal, .bottom], 14)
                    .padding(.bottom, 2)
                    .padding(.top, 12)
                    .background {
                        FlouTransparent(tailleFlou: 16)
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
            .glassEffect(.regular.interactive(), in: .rect(cornerRadius: arrondiImage, style: .continuous))
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
        HStack(spacing: 12) {
            // Nom Attraction
            Text(attraction.nomCourt ?? attraction.nom)
                .font(.descriptionImportante)
                .foregroundStyle(Color.white)
                .lineLimit(2)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                .frame(minHeight: UIFont(name: Polices.MontserratSemiBold, size: 13)!.lineHeight * 2)
                .truncationMode(.tail)
            
            IndicateurAttente(tempsAttente: attraction.informations?.tempsAttente ?? 0, fonctionnement: attraction.informations?.fonctionnement ?? .inconnu)
        }
        //.padding(.horizontal, borduresHorizontalesVueTitre)
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
        tempsAttente: 15,
        tempsSingleRider: nil,
        horaireFermeture: Date(),
        fonctionnement: .enMarche
    ))
    
    return FondPrincipal {
        CarteAttraction(namespace: animationRangAttraction, attraction: attraction)
    }
}
