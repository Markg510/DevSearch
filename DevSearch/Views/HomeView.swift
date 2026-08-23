//
//  HomeView.swift
//  DevSearch
//
//  Created by Mark George on 23/08/2026.
//

import SwiftUI

struct HomeView: View {
    @State private var search = ""
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                header
                
                clients
            }.padding()
                .searchable(text: $search)
        }
        .background(.appBg)
            
    }
    
    private var header: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Github")
                    .fontWeight(.medium)
                    .font(.title2)
                    .foregroundStyle(.lightBabyBlue)
                
                Text("Developers")
                    .foregroundStyle(.textPrimary)
                    .font(.largeTitle)
                    .fontWeight(.bold)
            }
            
            Spacer()
            
            Image(systemName: "gear")
                .font(.title3)
                .foregroundStyle(.textPrimary)
                .padding(8)
                .background(.textTertiary)
                .clipShape(.rect(cornerRadius: 16))
        }.padding(.bottom, 8)
    }
    
    @ViewBuilder
    private var clients: some View {
        Label("Featured", systemImage: "star.fill")
            .foregroundStyle(.textPrimary)
            .symbolRenderingMode(.multicolor)
            
        
        ForEach(0...5, id: \.self) { _ in
            DetailedDeveloperItem()
        }
    }
}

#Preview {
    NavigationStack {
        HomeView()
    }
}
