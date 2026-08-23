//
//  ErrorView.swift
//  DevSearch
//
//  Created by Mark George on 23/08/2026.
//

import SwiftUI

struct ErrorView: View {
    var errorDescription: String = "This is a sample error, please try again later"

    var body: some View {
        VStack {
            icon
            title
            message
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .center)
        .background(cardBackground)
    }

    private var icon: some View {
        Image(systemName: "i.circle")
            .foregroundStyle(.white.opacity(0.5))
            .background {
                Image(systemName: "i.circle")
                    .foregroundStyle(.appRed)
            }
            .font(.title2)
            .padding()
            .background(iconBackground)
    }

    private var title: some View {
        Text("Something went wrong")
            .foregroundStyle(.white)
            .font(.title2)
    }

    private var message: some View {
        Text(errorDescription)
            .foregroundStyle(.textSecondary)
            .font(.footnote)
    }

    private var iconBackground: some View {
        RoundedRectangle(cornerRadius: 16)
            .fill(.appRed.opacity(0.15))
            .stroke(.appRed.opacity(0.25))
    }

    private var cardBackground: some View {
        RoundedRectangle(cornerRadius: 16)
            .fill(.appRed.opacity(0.08))
            .stroke(.appRed.opacity(0.2))
    }
}

#Preview {
    VStack {
        ErrorView()
    }
    .padding()
    .background(.appBg)
}
