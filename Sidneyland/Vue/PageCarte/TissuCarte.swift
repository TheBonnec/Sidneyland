//
//  TissuCarte.swift
//  Sidneyland
//
//  Created by Thomas Le Bonnec on 29/11/2024.
//

import SwiftUI

struct TissuCarte: View {
    
    // MARK: Attributs
    
    let largeurImage: Double
    let hauteurImage: Double
    @State var dimensionsÉcran: CGRect = .zero
    @Binding var décalage: CGSize
    @Binding var agrandissement: CGFloat
    @Binding var favorisUniquement: Bool
    
    @EnvironmentObject var gestionnaire: GestionnaireAttractions
    
    @State var ratioLargeur: Double
    @State var ratioHauteur: Double
    @State var facteur: Double
    
    @State var importanceAcceptée: Int = 1
    
    let points = [UnitPoint(x: -0.13671875, y: -0.0927734375), UnitPoint(x: -0.0125, y: -0.04833984375)]
    
    
    
    // MARK: Init
    
    init(largeurImage: Double, hauteurImage: Double, décalage: Binding<CGSize>, agrandissement: Binding<CGFloat>, favorisUniquement: Binding<Bool>) {
        self.largeurImage = largeurImage
        self.hauteurImage = hauteurImage
        self._décalage = décalage
        self._agrandissement = agrandissement
        self.ratioHauteur = 0
        self.ratioLargeur = 0
        self.facteur = 0
        self._favorisUniquement = favorisUniquement
    }
    
    
    
    // MARK: Vue
    
    var body: some View {
        Color.clear
            .overlay {
                coucheIndicateursAttente
            }
            .scaleEffect(agrandissement)
            .offset(décalage)
            .background(
                GeometryReader { geo in
                    Color.clear
                        .onAppear {
                            dimensionsÉcran = geo.frame(in: .global)
                            calculerRatios()
                        }
                        .onChange(of: geo.frame(in: .global)) { avant, après in
                            dimensionsÉcran = geo.frame(in: .global)
                            calculerRatios()
                        }
                }
            )
            .onChange(of: agrandissement) {
                calculerImportanceAcceptée()
            }
            .onAppear {
                calculerImportanceAcceptée()
            }
    }
    
    
    var coucheIndicateursAttente: some View {
        ZStack {
            ForEach(gestionnaire.attractions, id: \.id) { attraction in
                if let importance = attraction.importance, importance <= importanceAcceptée, (favorisUniquement && attraction.estFavorite) || !favorisUniquement {
                    Group {
                        if !gestionnaire.chargement {
                            BulleTempsAttente(attraction: attraction)
                        } else {
                            Rectangle()
                                .frame(width: 44, height: 44)
                                .foregroundStyle(Color.gray)
                                .bordureArrondie(rayon: 1000, épaisseur: 2, couleur: .white.opacity(0.5))
                        }
                    }
                    .offset(interpolerPoint(point: attraction.positionCarte ?? UnitPoint.zero))
                    .scaleEffect(1 / agrandissement)
                }
            }
        }
    }
    
    
    
    // MARK: Méthodes
    
    func calculerRatios() {
        ratioHauteur = hauteurImage / dimensionsÉcran.height
        ratioLargeur = largeurImage / dimensionsÉcran.width
        facteur = ratioLargeur / ratioHauteur
    }
    
    
    func interpolerPoint(point: UnitPoint) -> CGSize {
        if ratioHauteur < ratioLargeur {
            return CGSize(
                width: (point.x * dimensionsÉcran.width * agrandissement * facteur),
                height: point.y * dimensionsÉcran.height * agrandissement
            )
        } else if facteur != 0 {
            return CGSize(
                width: point.x * dimensionsÉcran.width * agrandissement,
                height: (point.y * dimensionsÉcran.height * agrandissement) / facteur
            )
        }
        return CGSize(
            width: point.x * dimensionsÉcran.width * agrandissement,
            height: point.y * dimensionsÉcran.height * agrandissement
        )
    }
    
    
    func calculerImportanceAcceptée() {
        if agrandissement <= 1.5 {
            importanceAcceptée = 1
        } else if agrandissement <= 2 {
            importanceAcceptée = 2
        } else if agrandissement <= 3 {
            importanceAcceptée = 3
        } else {
            importanceAcceptée = 4
        }
    }
}





#Preview {
    TissuCarte(largeurImage: 7680, hauteurImage: 8192, décalage: .constant(.zero), agrandissement: .constant(1), favorisUniquement: .constant(false))
        .environmentObject(GestionnaireAttractions())
}
