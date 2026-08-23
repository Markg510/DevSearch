//
//  SearchDeveloperItem.swift
//  DevSearch
//
//  Created by Mark George on 23/08/2026.
//

import SwiftUI

struct SearchDeveloperItem: View {
    var body: some View {
        HStack {
            avatar

            developerInfo

            Spacer()

            stats

            chevron
        }
        .padding()
        .background(.colorPrimary)
    }

    private var avatar: some View {
        RoundedRectangle(cornerRadius: 16)
            .fill(.textSecondary)
            .frame(width: 44, height: 44)
            .padding(.trailing)
    }

    private var developerInfo: some View {
        VStack(alignment: .leading) {
            Text("John Doe")
                .font(.headline)
                .fontWeight(.medium)
                .foregroundStyle(.textPrimary)

            Text("@johndoe123")
                .foregroundStyle(.textSecondary)
                .font(.footnote)
        }
    }

    private var stats: some View {
        VStack(alignment: .trailing) {
            statItem("12", icon: "bookmark.fill", color: .appBlue)
            statItem("9.8k", icon: "person.fill", color: .appPurple)
        }
        .font(.footnote)
        .padding(.trailing)
    }

    private var chevron: some View {
        Image(systemName: "chevron.right")
            .foregroundStyle(.textSecondary)
    }

    private func statItem(_ value: String, icon: String, color: Color) -> some View {
        Label(value, systemImage: icon)
            .foregroundStyle(color)
    }
}

#Preview {
    SearchDeveloperItem()
}
