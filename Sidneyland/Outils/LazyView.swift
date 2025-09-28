//
//  LazyView.swift
//  Sidneyland
//
//  Created by Thomas Le Bonnec on 28/11/2024.
//

import SwiftUI

struct LazyView<Content: View>: View {
    let build: () -> Content

    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }

    var body: Content {
        build()
    }
}
