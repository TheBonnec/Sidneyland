//
//  BoutonFavori.swift
//  Sidneyland
//
//  Created by Thomas Le Bonnec on 28/11/2024.
//

import SwiftUI

struct BoutonFavori: View {
    
    // MARK: Attributs
    
    var attraction: Attraction
    
    @EnvironmentObject var vm: AppVM
    
    
    
    // MARK: Vue
    
    var body: some View {
        Button {
            if attraction.estFavorite {
                vm.enleverAttractionFavorite(attraction: attraction)
            } else {
                vm.ajouterAttractionFavorite(attraction: attraction)
            }
        } label: {
            if attraction.estFavorite {
                imageFavori
            } else {
                imageNonFavori
            }
        }
        .padding()
    }
    
    
    var imageNonFavori: some View {
        Image(systemName: "heart")
            .font(.information)
            .foregroundColor(.purple)
            .padding(12)
            .background(Color.white)
            .clipShape(Circle())
            .shadow(color: .black.opacity(0.1), radius: 8)
    }
    
    
    var imageFavori: some View {
        Image(systemName: "heart.fill")
            .font(.information)
            .foregroundColor(.white)
            .padding(12)
            .background(Color.purple)
            .clipShape(Circle())
            .shadow(color: .black.opacity(0.1), radius: 8)
    }
}





#Preview {
    BoutonFavori(attraction: RegistreAttractions.attractions()[0])
        .environmentObject(AppVM())
}
