//
//  TailleEcran.swift
//  Sidneyland
//
//  Created by Thomas Le Bonnec on 19/11/2024.
//

import SwiftUI


class TailleEcran: ObservableObject {
    @Published var largeur: CGFloat = 0
    @Published var hauteur: CGFloat = 0
    @Published var safeAreaTop: CGFloat = 0
    
    
    func configurerTaille(taille: CGRect, safeAreaTop: CGFloat) {
        self.largeur = taille.width
        self.hauteur = taille.height + safeAreaTop
        self.safeAreaTop = safeAreaTop
    }
}
