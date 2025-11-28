//
//  SidneylandApp.swift
//  Sidneyland
//
//  Created by Thomas Le Bonnec on 15/09/2024.
//

import SwiftUI

@main
struct SidneylandApp: App {
    
    @StateObject var gestionnaireAttractions = GestionnaireAttractions()
    
    
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(gestionnaireAttractions)
        }
    }
}
