//
//  FeaturedClients.swift
//  DevSearch
//
//  Created by Mark George on 23/08/2026.
//

import SwiftUI

struct FeaturedClients: View {
    var body: some View {
        Label(
            HomeContent.featured.title,
            systemImage: HomeContent.featured.icon
        )
        .foregroundStyle(.textPrimary)
        .symbolRenderingMode(.multicolor)
    }
}

#Preview {
    FeaturedClients()
}
