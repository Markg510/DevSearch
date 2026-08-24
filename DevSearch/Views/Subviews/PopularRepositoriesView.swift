//
//  PopularRepositoriesView.swift
//  DevSearch
//
//  Created by Mark George on 24/08/2026.
//

import SwiftUI

struct PopularRepositoriesView: View {
    let repos: [Repository]
    
    var body: some View {
        if !repos.isEmpty {
            VStack(alignment: .leading, spacing: 12) {
                Text("Popular Repositories")
                    .fontWeight(.medium)
                    .foregroundStyle(.textSecondary)
                
                ForEach(repos) { repo in
                    repoItem(repo)
                }
            }
        }
    }
    
    private func repoItem(_ repo: Repository) -> some View {
        VStack(alignment: .leading) {
            HStack {
                Text(repo.name)
                    .fontWeight(.medium)
                    .foregroundStyle(.textPrimary)
                
                Spacer()
                
                Label(
                    repo.stargazersCount.formattedValue(),
                    systemImage: "star.fill"
                )
                .foregroundStyle(.textTertiary)
            }
            
            Text(repo.description ?? "Unavailable")
                .font(.footnote)
                .foregroundStyle(.textSecondary)
            
            if let language = repo.language {
                languageItem(language)
            }
        }
        .padding()
        .surface()
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
}

#Preview {
    PopularRepositoriesView(repos: [])
}
