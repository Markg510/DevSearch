//
//  DeveloperVM.swift
//  DevSearch
//
//  Created by Mark George on 24/08/2026.
//

import Foundation

@Observable class DeveloperVM {
    var developer: Developer? = nil
    var repos: [Repository] = []
    
    var topLanguagesArray: [ProgrammingLanguage] {
        Dictionary(grouping: repos.compactMap(\.language)) { $0 }
            .sorted { $0.value.count > $1.value.count }
            .prefix(3)
            .map(\.key)
    }
    
    func fetchDeveloper(login: String) async throws {
        guard let githubToken = Bundle.main.object(
            forInfoDictionaryKey: "GITHUB_TOKEN"
        ) as? String else {
            throw URLError(.userAuthenticationRequired)
        }

        let url = URL(string: "https://api.github.com/users/\(login)")!

        var request = URLRequest(url: url)

        request.setValue(
            "Bearer \(githubToken)",
            forHTTPHeaderField: "Authorization"
        )

        request.setValue(
            "application/vnd.github+json",
            forHTTPHeaderField: "Accept"
        )

        request.setValue(
            "2026-03-10",
            forHTTPHeaderField: "X-GitHub-Api-Version"
        )

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let response = response as? HTTPURLResponse,
              200..<300 ~= response.statusCode else {
            throw URLError(.badServerResponse)
        }

        developer = try JSONDecoder().decode(Developer.self, from: data)
    }
    
    func fetchRepositories(of username: String) async throws {
        let url = URL(
            string: "https://api.github.com/users/\(username)/repos?per_page=100"
        )!

        var request = URLRequest(url: url)

        guard let githubToken = Bundle.main.object(
            forInfoDictionaryKey: "GITHUB_TOKEN"
        ) as? String else {
            throw URLError(.userAuthenticationRequired)
        }
        
        request.setValue(
            "Bearer \(githubToken)",
            forHTTPHeaderField: "Authorization"
        )

        request.setValue(
            "application/vnd.github+json",
            forHTTPHeaderField: "Accept"
        )

        request.setValue(
            "2026-03-10",
            forHTTPHeaderField: "X-GitHub-Api-Version"
        )

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let response = response as? HTTPURLResponse,
              200..<300 ~= response.statusCode else {
            throw URLError(.badServerResponse)
        }

        repos = try JSONDecoder().decode(
            [Repository].self,
            from: data
        )
        
        repos = Array(repos
            .sorted { $0.stargazersCount > $1.stargazersCount }
            .prefix(3)
        )
    }
}
