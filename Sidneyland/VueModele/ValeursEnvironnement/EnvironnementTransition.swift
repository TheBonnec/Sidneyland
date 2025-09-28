//
//  EnvironnementTransition.swift
//  Sidneyland
//
//  Created by Thomas Le Bonnec on 28/11/2024.
//

import SwiftUI

extension EnvironmentValues {
    var progressionTransitionModale: CGFloat {
        get { return self[ClefTransitionModale.self] }
        set { self[ClefTransitionModale.self] = newValue }
    }
}


public struct ClefTransitionModale: EnvironmentKey {
    public static let defaultValue: CGFloat = 0
}
