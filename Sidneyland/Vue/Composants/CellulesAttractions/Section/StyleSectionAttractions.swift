//
//  StyleSectionAttractions.swift
//  Sidneyland
//
//  Created by Thomas Le Bonnec on 06/10/2025.
//

import SwiftUI


@MainActor protocol StyleSectionAttractions {
    associatedtype Body: View
    
    @ViewBuilder @MainActor func créerCorps(configuration: ConfigurationSectionAttractions) -> Self.Body
}



extension StyleSectionAttractions where Self == StyleSectionCartesAttractions {
    @MainActor static var cartes: Self {
        get {
            return Self()
        }
    }
}

extension StyleSectionAttractions where Self == StyleSectionRangsAttractions {
    @MainActor static var rangs: Self {
        get {
            return Self()
        }
    }
}




extension SectionAttractions {
    func style<S: StyleSectionAttractions>(_ style: S) -> SectionAttractions<S> {
        return SectionAttractions<S>(config: self.config, style: style)
    }
}

