//
//  LaunchView.swift
//  DevSearch
//
//  Created by Mark George on 22/08/2026.
//

import SwiftUI

struct LaunchView: View {
    // View Properties
    @State private var circleCount = 1
    @State private var isFirstLaunch = true
    
    var body: some View {
        VStack {
            icon
            loadingDots
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.appBg)
        .onAppear {
            if isFirstLaunch {
                Task {
                    try await Task.sleep(nanoseconds: 1_000_000_000)
                    withAnimation {
                        isFirstLaunch = false
                    }
                }
            }
        }
    }
    
    private var icon: some View {
        Image(.icon)
            .resizable()
            .aspectRatio(1, contentMode: .fit)
            .frame(width: 158, height: 136)
    }

    @ViewBuilder
    private var loadingDots: some View {
        if !isFirstLaunch {
            // Animate 1 -> 2 -> 3 dots repeatedly while preparing
            TimelineView(.periodic(from: .now, by: 0.5)) { context in
                // Compute how many dots to show based on time slice
                let elapsed = context.date.timeIntervalSinceReferenceDate
                let phase = Int(elapsed / 0.5) % 3 // 0,1,2
                let dots = String(repeating: ".", count: phase + 1)

                Text(dots)
                    .foregroundStyle(.appBlue)
                    .font(.largeTitle)
                    .contentTransition(.numericText())
                    .animation(.easeInOut(duration: 0.25), value: phase)
            }
        }
    }
}

#Preview {
    LaunchView()
}
