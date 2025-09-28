//
//  SidneylandTests.swift
//  SidneylandTests
//
//  Created by Thomas Le Bonnec on 15/09/2024.
//

import Testing
@testable import Sidneyland

struct SidneylandTests {

    @Test func example() async throws {
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
        try await APIDisneyland.obtenirDonnées()
    }

}
