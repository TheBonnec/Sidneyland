//
//  Animations.swift
//  Sidneyland
//
//  Created by Thomas Le Bonnec on 28/11/2024.
//

import SwiftUI

extension Animation {
    static var ressort: Animation {
        .spring(duration: 0.3, bounce: 0.2)
    }
    
    static var ressortRapide: Animation {
        .spring(duration: 0.2, bounce: 0.2)
    }
}
