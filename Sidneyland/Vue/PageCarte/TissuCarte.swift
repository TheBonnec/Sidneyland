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
    
    @EnvironmentObject var appVM: AppVM
    
    @State var ratioLargeur: Double
    @State var ratioHauteur: Double
    @State var facteur: Double
    
    @State var importanceAcceptée: Int = 1
    @State var attractions: [Attraction] = []
    
    let points = [UnitPoint(x: -0.13671875, y: -0.0927734375), UnitPoint(x: -0.0125, y: -0.04833984375)]
    
    
    
    // MARK: Init
    
    init(largeurImage: Double, hauteurImage: Double, décalage: Binding<CGSize>, agrandissement: Binding<CGFloat>) {
        self.largeurImage = largeurImage
        self.hauteurImage = hauteurImage
        self._décalage = décalage
        self._agrandissement = agrandissement
        self.ratioHauteur = 0
        self.ratioLargeur = 0
        self.facteur = 0
    }
    
    
    
    // MARK: Vue
    
    var body: some View {
        Color.clear
        //.frame(width: largeurImage, height: hauteurImage)
            .overlay {
                ZStack {
                    ForEach(attractions, id: \.id) { attraction in
                        if let informations = attraction.informations {
                            Group {
                                if !appVM.chargement {
                                    IndicateurAttente(tempsAttente: informations.tempsAttente, fonctionnement: informations.fonctionnement)
                                        .overlay {
                                            if attraction.estFavorite {
                                                RoundedRectangle(cornerRadius: 8)
                                                    .stroke(Color.purple, lineWidth: 4)
                                            }
                                        }
                                } else {
                                    Rectangle()
                                        .frame(width: 50, height: 60)
                                        .foregroundStyle(Color.gray)
                                }
                            }
                            .background(Color.white)
                            .bordureArrondie(rayon: 8)
                            .offset(interpolerPoint(point: attraction.positionCarte ?? UnitPoint.zero))
                            .scaleEffect(1 / agrandissement)
                        }
                    }
                }
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
            .onChange(of: agrandissement) { avant, après in
                calculerImportanceAcceptée()
                obtenirAttractions()
            }
            .onAppear {
                calculerImportanceAcceptée()
                obtenirAttractions()
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
    
    
    func obtenirAttractions() {
        attractions.removeAll()
        for attraction in appVM.attractions {
            if attraction.positionCarte != nil, attraction.importance ?? 5 <= importanceAcceptée {
                attractions.append(attraction)
            }
        }
    }
}





#Preview {
    TissuCarte(largeurImage: 7680, hauteurImage: 8192, décalage: .constant(.zero), agrandissement: .constant(1))
        .environmentObject(AppVM())
}
