//
//  PageCarte.swift
//  Sidneyland
//
//  Created by Thomas Le Bonnec on 23/11/2024.
//

import SwiftUI

struct PageCarte: View {
    
    // MARK: Attributs
    
    @State private var scale: CGFloat = 1.0 // Zoom
    @State private var offset: CGSize = .zero // Déplacement
    @State private var lastOffset: CGSize = .zero // Dernière position
    
    
    
    // MARK: Vue
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}





#Preview {
    PageCarte()
}
