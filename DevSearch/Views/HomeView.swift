//
//  HomeView.swift
//  DevSearch
//
//  Created by Mark George on 23/08/2026.
//

import SwiftUI

struct HomeView: View {
    // View Properties
    @AppStorage("homeContent") private var homeContent: HomeContent = .featured
    @State private var gvm = GeneralVM()
    @State private var vm = HomeVM()
    @State private var showSettingsSheet = false
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
            
            settingsIcon
        }.padding(.bottom, 8)
            .sheet(isPresented: $showSettingsSheet) {
                SettingsView()
                    .presentationDetents([.medium])
            }
    }
    
    private var settingsIcon: some View {
        Button {
            showSettingsSheet = true
        } label: {
            Image(systemName: "gear")
                .font(.title3)
                .foregroundStyle(.textPrimary)
                .padding(8)
                .background(.textTertiary.opacity(0.5))
                .clipShape(.rect(cornerRadius: 16))
                .shadow(radius: 1)
        }
    }
    
    @ViewBuilder
    private var clients: some View {
        switch homeContent {
        case .featured:
            FeaturedClients()
        case .bookmarked:
            BookmarkedClients()
        case .previousResults:
            SavedClients()
        }
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
