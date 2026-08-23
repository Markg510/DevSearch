//
//  DeveloperView.swift
//  DevSearch
//
//  Created by Mark George on 23/08/2026.
//

import SwiftUI

struct DeveloperView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                header
                userStats
                location
                topLanguages
                recentRepos
                githubButton
            }.padding()
        }.background(.appBg)
    }
    
    @ViewBuilder
    private var header: some View {
        VStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(.textSecondary)
                .frame(width: 100, height: 100)
            
            Text("John Doe")
                .font(.title)
                .fontWeight(.medium)
                .foregroundStyle(.textPrimary)
            
            Text("@johndoe123")
                .foregroundStyle(.textSecondary)
            
            Text("Experienced IOS Developer")
                .foregroundStyle(.textTertiary)
                .font(.caption)
                .lineLimit(1)
        }.padding()
            .frame(maxWidth: .infinity, alignment: .center)
            .surface(background: headerBackground)
            .padding(.bottom)
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
            statItem(value: 7, description: "repos")
            
            Divider()
                .overlay(.textTertiary)
            
            statItem(value: 230_000, description: "followers")
            
            Divider()
                .overlay(.textTertiary)
            
            statItem(value: 0, description: "following")
        }.padding(.horizontal)
            .surface()
            .frame(height: 70)
    }
    
    private func statItem(value: Int, description: String) -> some View {
        VStack {
            Text(value.formattedValue())
                .font(.title3)
                .fontWeight(.medium)
                .foregroundStyle(.textPrimary)
            
            Text(description)
                .font(.footnote)
                .foregroundStyle(.textSecondary)
        }.frame(maxWidth: .infinity, alignment: .center)
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
                
                Text("Port Said, Egypt")
                    .font(.callout)
                    .foregroundStyle(.textPrimary)
            }
            
            Spacer()
        }.padding()
            .surface()
    }
    
    private var topLanguages: some View {
        VStack(alignment: .leading) {
            Text("Top Languages")
                .foregroundStyle(.textSecondary)
                .fontWeight(.medium)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    languageItem(.c)
                    languageItem(.cpp)
                    languageItem(.assembly)
                }
            }
        }.padding()
            .surface()
            .padding(.bottom)
    }
    
    private func languageItem(_ language: ProgrammingLanguage) -> some View {
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
    
    @ViewBuilder
    private var recentRepos: some View {
        Text("Recent Repositories")
            .fontWeight(.medium)
            .foregroundStyle(.textSecondary)
        
        repoItem(
            title: "torval-core",
            description: "Core library and utilities for the project ecosystem",
            language: "Typescript",
            stars: 3751
        )
        
        repoItem(
            title: "torval-cli",
            description: "Command-line interface with plugin support and auto-completion",
            language: "Go",
            stars: 3751
        ).padding(.bottom)
    }
    
    private func repoItem(
        title: String,
        description: String,
        language: String,
        stars: Int
    ) -> some View {
        VStack(alignment: .leading) {
            HStack {
                Text(title)
                    .fontWeight(.medium)
                    .foregroundStyle(.textPrimary)
                
                Spacer()
                
                Label(stars.formattedValue(), systemImage: "star.fill")
                    .foregroundStyle(.textTertiary)
            }
            
            Text(description)
                .font(.footnote)
                .foregroundStyle(.textSecondary)
            
            HStack {
                Circle()
                    .fill(.appBlue)
                    .frame(width: 8, height: 8)
                
                Text("Typescript")
                    .foregroundStyle(.textTertiary)
            }
        }
        .padding()
        .surface()
    }
    
    private var githubButton: some View {
        AppButton(title: "View on Github", icon: .image("icon")) {}
    }
}

#Preview {
    DeveloperView()
}
