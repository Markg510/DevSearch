//
//  DeveloperView.swift
//  DevSearch
//
//  Created by Mark George on 23/08/2026.
//

import SwiftUI

struct DeveloperView: View {
    // Passed Properties
    let login: String
    
    // View Properties
    @Environment(\.openURL) private var openURL
    @State private var vm = DeveloperVM()
    
    @State private var viewMode: ViewMode = .success
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                viewMode.errorView
                header
                userStats
                location
                topLanguages
                popularRepos
                githubButton
            }.padding()
        }.background(.appBg)
            .task {
                handleFetchingDeveloperDetails()
            }
    }
    
    @ViewBuilder
    private var header: some View {
        VStack {
            Group {
                if let url = vm.developer?.pfpURL {
                    CustomImage(viewType: .urlAvailable(url: url))
                } else {
                    CustomImage(viewType: .loadingURL)
                }
            }.frame(width: 100, height: 100)
                .clipShape(.rect(cornerRadius: 16))
            
            Text(isUnavailable(vm.developer?.name))
                .font(.title)
                .fontWeight(.medium)
                .foregroundStyle(.textPrimary)
            
            Text(login)
                .foregroundStyle(.textSecondary)
            
            Text(isUnavailable(vm.developer?.bio))
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
            statItem(value: vm.developer?.publicRepos ?? 0, description: "repos")
            
            Divider()
                .overlay(.textTertiary)
            
            statItem(value: vm.developer?.followers ?? 0, description: "followers")
            
            Divider()
                .overlay(.textTertiary)
            
            statItem(value: vm.developer?.following ?? 0, description: "following")
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
                
                Text(isUnavailable(vm.developer?.location))
                    .overlay {
                        if viewMode.isLoading {
                            LoadingView(.rect(cornerRadius: 16))
                        }
                    }
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
            
            if vm.topLanguagesArray.isEmpty && !viewMode.isLoading {
                Text("Unavailable")
                    .font(.footnote)
                    .foregroundStyle(.textTertiary)
            } else if vm.topLanguagesArray.isEmpty && viewMode.isLoading {
                Text("Loading_Loading_Loading)")
                    .overlay(LoadingView(.rect(cornerRadius: 16)))
            } else if !vm.topLanguagesArray.isEmpty && !viewMode.isLoading {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(vm.topLanguagesArray) { language in
                            languageItem(language)
                        }
                    }
                }
            }
        }.padding()
            .frame(maxWidth: .infinity, alignment: .leading)
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
    private var popularRepos: some View {
        if !vm.repos.isEmpty {
            Text("Popular Repositories")
                .fontWeight(.medium)
                .foregroundStyle(.textSecondary)
            
            ForEach(vm.repos) { repo in
                repoItem(
                    title: repo.name,
                    description: repo.description ?? "Unavailable",
                    language: repo.language ?? .go,
                    stars: repo.stargazersCount
                )
            }
        }
    }
    
    private func repoItem(
        title: String,
        description: String,
        language: ProgrammingLanguage,
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
            
            languageItem(language)
        }
        .padding()
        .surface()
    }
    
    private var githubButton: some View {
        AppButton(title: "View on Github", icon: .image("icon")) {
            guard let urlString = vm.developer?.htmlURL else { return }
            guard let url = URL(string: urlString) else { return }
            openURL(url)
        }.padding(.top)
    }
    
    private func isUnavailable(_ value: String?) -> String {
        if viewMode.isLoading {
            "Loading..."
        } else {
            value ?? "Unavailable"
        }
    }
    
    // MARK: HANDLERS
    private func handleFetchingDeveloperDetails() {
        Task {
            do {
                viewMode = .loading(label: "Fetching Developer Details")
                try await vm.fetchDeveloper(login: login)
                try await vm.fetchRepositories(of: login)
                
                viewMode = .success
            } catch {
                viewMode = .failure(error: error)
            }
        }
    }
}

#Preview {
    DeveloperView(login: "TorvaldsDB")
}
