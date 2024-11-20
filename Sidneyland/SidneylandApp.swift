//
//  SidneylandApp.swift
//  Sidneyland
//
//  Created by Thomas Le Bonnec on 15/09/2024.
//

import SwiftUI

@main
struct SidneylandApp: App {
    
    @StateObject var tailleÉcran = TailleEcran()
    
    
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(tailleÉcran)
        }
    }
}
