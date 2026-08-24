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
                
                DeveloperProfileView(
                    developer: vm.developer,
                    topLanguages: vm.topLanguagesArray,
                    viewMode: viewMode
                )
                
                PopularRepositoriesView(
                    repos: vm.repos
                )
                
                githubButton
            }
            .padding()
        }
        .background(.appBg)
        .task {
            handleFetchingDeveloperDetails()
        }
    }
    
    private var githubButton: some View {
        AppButton(title: "View on Github", icon: .image("icon")) {
            guard let urlString = vm.developer?.htmlURL else { return }
            guard let url = URL(string: urlString) else { return }
            openURL(url)
        }
        .padding(.top)
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
