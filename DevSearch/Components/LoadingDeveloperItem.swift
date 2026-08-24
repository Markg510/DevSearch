//
//  LoadingDeveloperItem.swift
//  DevSearch
//
//  Created by Mark George on 24/08/2026.
//

import SwiftUI

struct LoadingDeveloperItem: View {
        var body: some View {
        HStack {
            avatar

            developerInfo

            Spacer()

            chevron
        }
        .padding()
        .surface()
    }

    private var avatar: some View {
        LoadingView(.rect(cornerRadius: 16))
        .frame(width: 44, height: 44)
        .padding(.trailing)
    }

    private var developerInfo: some View {
        VStack(alignment: .leading) {
            Text("@johndoe123again1234")
                .overlay(
                    LoadingView(.rect(cornerRadius: 28))
                )
                .font(.headline)
                .fontWeight(.medium)
                .foregroundStyle(.textPrimary)

            HStack(spacing: 0) {
                Text("#")
                Text(1_000_353_300_300, format: .number)
            }
            .overlay(
                LoadingView(.rect(cornerRadius: 28))
            )
            .foregroundStyle(.textSecondary)
            .font(.footnote)
        }
    }

    private var chevron: some View {
        Image(systemName: "chevron.right")
            .foregroundStyle(.textSecondary)
    }
}

#Preview {
    LoadingDeveloperItem()
}
