//
//  DetailedDeveloperItem.swift
//  DevSearch
//
//  Created by Mark George on 22/08/2026.
//

import SwiftUI

struct DetailedDeveloperItem: View {
    var body: some View {
        VStack(alignment: .leading) {
            header

            description

            Divider()
                .overlay(.textSecondary)
                .padding(.vertical, 8)

            stats
        }
        .padding(.vertical)
        .background(.colorPrimary)
        .clipShape(.rect(cornerRadius: 28))
        .shadow(color: .textSecondary, radius: 1)
    }

    private var header: some View {
        HStack {
            avatar

            VStack(alignment: .leading) {
                Text("John Doe")
                    .foregroundStyle(.textPrimary)

                Text("@johndoe123")
                    .foregroundStyle(.textSecondary)
            }

            Spacer()

            actionButton(icon: "bookmark", background: .textQuaternary)
            actionButton(icon: "chevron.right", background: .lightBlue)
        }
        .padding(.horizontal)
    }

    private var avatar: some View {
        RoundedRectangle(cornerRadius: 16)
            .fill(.textSecondary)
            .frame(width: 60, height: 60)
            .padding(.trailing, 8)
    }

    private var description: some View {
        Text("This is a sample description text")
            .foregroundStyle(.textSecondary)
            .lineLimit(1)
            .minimumScaleFactor(0.8)
            .padding(.horizontal)
    }

    private var stats: some View {
        HStack {
            dataItem("repos", value: 7, icon: "bookmark", background: .lightBlue)

            dataItem(
                "repos",
                value: 230_000,
                icon: "chevron.left.forwardslash.chevron.right",
                background: .lightPurple
            )

            dataItem(
                "following",
                value: 255,
                icon: "person.fill.badge.plus",
                background: .lightBlue
            )
        }
        .padding(.horizontal)
    }

    private func actionButton(icon: String, background: Color) -> some View {
        Image(systemName: icon)
            .foregroundStyle(.textPrimary)
            .padding(8)
            .padding(.horizontal, 3)
            .background(background)
            .clipShape(.rect(cornerRadius: 12))
    }

    private func dataItem(
        _ description: String,
        value: Int,
        icon: String,
        background: Color
    ) -> some View {
        Label {
            HStack {
                Text(value.formattedValue())
                    .font(.headline)
                    .foregroundStyle(.textPrimary)
                    .fontWeight(.medium)

                Text(description)
                    .font(.footnote)
                    .foregroundStyle(.textSecondary)
            }
        } icon: {
            Image(systemName: icon)
                .foregroundStyle(.textSecondary)
                .shadow(radius: 2)
        }
        .padding(8)
        .background(background)
        .clipShape(.rect(cornerRadius: 16))
        .lineLimit(1)
        .minimumScaleFactor(0.8)
    }
}

#Preview {
    DetailedDeveloperItem()
}
