//
//  SavedClients.swift
//  DevSearch
//
//  Created by Mark George on 23/08/2026.
//

import SwiftUI

struct SavedClients: View {
    var body: some View {
        Label(
            HomeContent.previousResults.title,
            systemImage: HomeContent.previousResults.icon
        )
        .foregroundStyle(.textPrimary)
        .symbolRenderingMode(.multicolor)
    }
}

#Preview {
    SavedClients()
}
