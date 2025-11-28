//
//  BordureArrondie.swift
//  Sidneyland
//
//  Created by Thomas Le Bonnec on 19/11/2024.
//

import SwiftUI

extension View {
    public func bordureArrondie(rayon: CGFloat, épaisseur: CGFloat = 1, couleur: Color = Color.clear) -> some View {
        self
            .clipShape(RoundedRectangle(cornerRadius: rayon, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: rayon, style: .continuous)
                    .stroke(couleur, lineWidth: épaisseur)
            )
    }
}
