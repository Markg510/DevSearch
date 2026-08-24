//
//  DeveloperProfileView.swift
//  DevSearch
//
//  Created by Mark George on 24/08/2026.
//

import SwiftUI


struct DeveloperProfileView: View {
    let developer: Developer?
    let topLanguages: [ProgrammingLanguage]
    let viewMode: ViewMode
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            header
            userStats
            location
            topLanguagesView
        }
    }
    
    private var header: some View {
        VStack {
            Group {
                if let url = developer?.pfpURL {
                    CustomImage(viewType: .urlAvailable(url: url))
                } else {
                    CustomImage(viewType: .loadingURL)
                }
            }
            .frame(width: 100, height: 100)
            .clipShape(.rect(cornerRadius: 16))
            
            Text(displayValue(developer?.name))
                .font(.title)
                .fontWeight(.medium)
                .foregroundStyle(.textPrimary)
            
            // Login is already known and is not part of GitHubUser
            // so it remains in DeveloperView if you want to show it.
            
            Text(displayValue(developer?.bio))
                .foregroundStyle(.textTertiary)
                .font(.caption)
                .lineLimit(1)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .center)
        .surface(background: headerBackground)
        .padding(.bottom)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                if viewMode.isLoading {
                    ProgressView()
                }
            }
        }
    }
    
    private var headerBackground: some View {
        ZStack {
            LinearGradient(
                colors: [
                    .appBlue,
                    .appPurple
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            
            Color.black.opacity(0.4)
        }
    }
    
    private var userStats: some View {
        HStack {
            statItem(
                value: developer?.publicRepos ?? 0,
                description: "repos"
            )
            
            Divider()
                .overlay(.textTertiary)
            
            statItem(
                value: developer?.followers ?? 0,
                description: "followers"
            )
            
            Divider()
                .overlay(.textTertiary)
            
            statItem(
                value: developer?.following ?? 0,
                description: "following"
            )
        }
        .padding(.horizontal)
        .surface()
        .frame(height: 70)
    }
    
    private func statItem(
        value: Int,
        description: String
    ) -> some View {
        VStack {
            Text(value.formattedValue())
                .font(.title3)
                .fontWeight(.medium)
                .foregroundStyle(.textPrimary)
            
            Text(description)
                .font(.footnote)
                .foregroundStyle(.textSecondary)
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .padding(.vertical, 10)
    }
    
    private var location: some View {
        HStack {
            Image(systemName: "mappin")
                .font(.title2)
                .symbolRenderingMode(.multicolor)
                .padding(.trailing, 8)
            
            VStack(alignment: .leading) {
                Text("Location")
                    .font(.footnote)
                    .foregroundStyle(.textSecondary)
                
                Text(displayValue(developer?.location))
                    .overlay {
                        if viewMode.isLoading {
                            LoadingView(.rect(cornerRadius: 16))
                        }
                    }
                    .font(.callout)
                    .foregroundStyle(.textPrimary)
            }
            
            Spacer()
        }
        .padding()
        .surface()
    }
    
    private var topLanguagesView: some View {
        VStack(alignment: .leading) {
            Text("Top Languages")
                .foregroundStyle(.textSecondary)
                .fontWeight(.medium)
            
            if topLanguages.isEmpty && !viewMode.isLoading {
                Text("Unavailable")
                    .font(.footnote)
                    .foregroundStyle(.textTertiary)
            } else if topLanguages.isEmpty && viewMode.isLoading {
                Text("Loading...")
                    .overlay {
                        LoadingView(.rect(cornerRadius: 16))
                    }
            } else {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(topLanguages) { language in
                            languageItem(language)
                        }
                    }
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .surface()
        .padding(.bottom)
    }
    
    private func languageItem(
        _ language: ProgrammingLanguage
    ) -> some View {
        HStack {
            Circle()
                .fill(language.color)
                .frame(width: 8, height: 8)
            
            Text(language.title)
                .font(.footnote)
                .foregroundStyle(language.color)
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
        .background(language.color.opacity(0.2))
        .clipShape(.rect(cornerRadius: 28))
        .shadow(color: language.color, radius: 2)
    }
    
    private func displayValue(_ value: String?) -> String {
        if viewMode.isLoading {
            "Loading..."
        } else {
            value ?? "Unavailable"
        }
    }
}

#Preview {
    DeveloperProfileView(developer: nil, topLanguages: [], viewMode: .success)
}
