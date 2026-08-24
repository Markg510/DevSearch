//
//  View+Extensions.swift
//  DevSearch
//
//  Created by Mark George on 23/08/2026.
//

import SwiftUI

extension View {
    func surface(background: some View = Color(.colorPrimary)) -> some View {
        self
            .background(background)
            .clipShape(.rect(cornerRadius: 16))
            .shadow(color: .white, radius: 1)
    }
}
