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
    @Published var safeAreaHaut: CGFloat = 0
    @Published var safeAreaBas: CGFloat = 0
    @Published var safeAreaGauche: CGFloat = 0
    @Published var safeAreaDroite: CGFloat = 0
    
    
    func configurerTaille(taille: CGRect, safeArea: EdgeInsets) {
        self.largeur = taille.width + safeArea.leading + safeArea.trailing
        self.hauteur = taille.height + safeArea.top + safeArea.bottom
        self.safeAreaHaut = safeArea.top
        self.safeAreaBas = safeArea.bottom
        self.safeAreaGauche = safeArea.leading
        self.safeAreaDroite = safeArea.trailing
    }
}
