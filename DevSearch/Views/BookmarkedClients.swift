//
//  BookmarkedClients.swift
//  DevSearch
//
//  Created by Mark George on 23/08/2026.
//

import SwiftUI

struct BookmarkedClients: View {
    var body: some View {
        Label(
            HomeContent.bookmarked.title,
            systemImage: HomeContent.bookmarked.icon
        )
        .foregroundStyle(.textPrimary)
        .symbolRenderingMode(.multicolor)
    }
}

#Preview {
    BookmarkedClients()
}
