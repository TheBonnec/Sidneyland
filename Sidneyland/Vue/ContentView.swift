//
//  ContentView.swift
//  Sidneyland
//
//  Created by Thomas Le Bonnec on 15/09/2024.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: Attributs
    
    @Namespace private var animationRangAttraction
    
    @EnvironmentObject var tailleÉcran: TailleEcran
    @EnvironmentObject var appVM: AppVM
    
    
    
    // MARK: Vue
    
    var body: some View {
        GeometryReader { géometrie in
            ZStack {
                vuePagePrincipale(géometrie)
                    .opacity(!appVM.détailEstAffiché ? 1 : 0)
                
                if appVM.détailEstAffiché {
                    vueDétails()
                }
            }
        }
    }
    
    
    
    @ViewBuilder
    func vuePagePrincipale(_ géometrie: GeometryProxy) -> some View {
        PagePrincipale(namespace: animationRangAttraction)
            .onAppear {
                self.tailleÉcran.configurerTaille(taille: géometrie.frame(in: .global), safeAreaTop: géometrie.safeAreaInsets.top)
            }
            .onChange(of: géometrie.frame(in: .global)) { avant, après in
                self.tailleÉcran.configurerTaille(taille: après, safeAreaTop: géometrie.safeAreaInsets.top)   // Si l'écran est tourné (iOS), ou que la fenêtre est redimensionnée (macOS)
            }
    }
    
    
    @ViewBuilder
    func vueDétails() -> some View {
        Group {
            if let attraction = appVM.attractionSélectionnée {
                PageDetailAttraction(namespace: animationRangAttraction, attraction: attraction) {
                    appVM.fermerDétail()
                }
            } else {
                Button {
                    appVM.fermerDétail()
                } label: {
                    VStack(alignment: .center, spacing: 16) {
                        Image(systemName: "questionmark")
                            .font(.titrePage)
                            .foregroundStyle(Color.gray)
                        
                        Text("Une erreur est survenue\nAppuyez pour revenir")
                            .font(.corps)
                            .padding()
                            .foregroundStyle(Color.white)
                            .background(Color.purple)
                            .bordureArrondie(rayon: 8)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                }
            }
        }
    }
}





#Preview {
    ContentView()
        .environmentObject(TailleEcran())
        .environmentObject(AppVM())
}
