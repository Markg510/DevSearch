//
//  AppButton.swift
//  DevSearch
//
//  Created by Mark George on 23/08/2026.
//

import SwiftUI

struct AppButton: View {
    enum IconType {
        case systemImage(String)
        case image(String)
    }

    let title: String
    let icon: IconType?
    let onPressed: () -> Void

    var body: some View {
        Button(action: onPressed) {
            label
                .foregroundStyle(.textPrimary)
                .padding()
                .frame(maxWidth: .infinity, alignment: .center)
                .background(background)
                .clipShape(.rect(cornerRadius: 16))
                .shadow(radius: 1)
        }
    }
    
    private var background: some View {
        ZStack {
            LinearGradient(
                colors: [
                    .appBlue,
                    .appPurple
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            
            Color.black.opacity(0.2)
        }
    }

    @ViewBuilder
    private var label: some View {
        if let icon {
            Label {
                Text(title)
            } icon: {
                iconImage(icon)
            }
        } else {
            Text(title)
        }
    }

    @ViewBuilder
    private func iconImage(_ icon: IconType) -> some View {
        switch icon {
        case .image(let path):
            Image(path)
                .resizable()
                .renderingMode(.template)
                .foregroundStyle(.white)
                .aspectRatio(1, contentMode: .fit)
                .frame(width: 20)

        case .systemImage(let path):
            Image(systemName: path)
        }
    }
}

#Preview {
    AppButton(title: "Test Mic", icon: .image("icon")) {}
    AppButton(title: "Test Mic", icon: .systemImage("bookmark.fill")) {}
}
