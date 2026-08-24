//
//  LaunchView.swift
//  DevSearch
//
//  Created by Mark George on 22/08/2026.
//

import SwiftUI

struct LaunchView: View {
    @State private var circleCount = 1
    @State private var firstLaunch = true
    
    var body: some View {
        VStack {
            icon
            details
            loadingDots
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(background)
            .onAppear {
                if firstLaunch {
                    Task {
                        try await Task.sleep(nanoseconds: 3_000_000_000)
                        withAnimation {
                            firstLaunch = false
                        }
                    }
                }
            }
    }
    
    private var icon: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 28)
                .fill(logoBg)
                .stroke(.appBlue.opacity(0.4), lineWidth: 2)
                .frame(width: 96, height: 96)
            
            Image(.icon)
                .resizable()
                .aspectRatio(1, contentMode: .fit)
                .frame(width: 40)
        }.padding(.bottom)
    }
    
    @ViewBuilder
    private var details: some View {
        Text("DevSearch")
            .font(.title)
            .foregroundStyle(.textPrimary)
            .fontWeight(.bold)
        
        Text("Discover Github Developers")
            .foregroundStyle(.textSecondary)
            .font(.footnote)
    }
    
    private var background: some View {
        ZStack {
            LinearGradient(colors: [.bgBlue, .bgBlack, .bgDarkBlue], startPoint: .top, endPoint: .bottom)
            
            radialBg
                .frame(width: 350, height: 350)
                .opacity(0.25)
                .offset(y: -75)
        }.ignoresSafeArea()
    }
    
    private var logoBg: LinearGradient {
        LinearGradient(colors: [.lightBlue, .lightPurple], startPoint: .top, endPoint: .bottom)
    }
    
    private var radialBg: RadialGradient {
        RadialGradient(
            stops: [
                .init(color: .appBlue, location: 0.0),
                .init(color: .clear, location: 0.65)
            ],
            center: .center,
            startRadius: 0,
            endRadius: 200
        )
    }
    
    @ViewBuilder
    private var loadingDots: some View {
        // Animate 1 -> 2 -> 3 dots repeatedly while preparing
        if !firstLaunch {
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
