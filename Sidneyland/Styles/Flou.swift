//
//  Flou.swift
//  Sidneyland
//
//  Created by Thomas Le Bonnec on 21/11/2024.
//

import SwiftUI

struct FlouTransparent: View {
    
    // MARK: Attributs
    
    var tailleFlou: CGFloat
    var largeur: CGFloat?
    var hauteur: CGFloat?
    
    
    // MARK: Vue
    
    var body: some View {
        VueFlouTransparent(supprimerTousLesFiltres: true)
            .blur(radius: tailleFlou)
            .frame(width: largeurAjustée(), height: hauteurAjustée())
            .padding([.horizontal, .bottom], -(tailleFlou * 2))
    }
    
    
    
    // MARK: Méthodes
    
    func largeurAjustée() -> CGFloat? {
        if let largeur {
            return largeur + (4 * tailleFlou)
        }
        return nil
    }
    
    func hauteurAjustée() -> CGFloat? {
        if let hauteur {
            return hauteur + (4 * tailleFlou)
        }
        return nil
    }
}





fileprivate struct VueFlouTransparent: UIViewRepresentable {
    
    // MARK: Attributs
    
    var supprimerTousLesFiltres: Bool = false
    
    
    
    // MARK: Méthodes
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        let vue = UIVisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterial))
        return vue
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        DispatchQueue.main.async {
            if let coucheDeFond = uiView.layer.sublayers?.first {
                if supprimerTousLesFiltres {
                    coucheDeFond.filters = []
                } else {
                    coucheDeFond.filters?.removeAll(where: { filtre in
                        String(describing: filtre) != "gaussianBlur"
                    })
                }
            }
        }
    }
}
