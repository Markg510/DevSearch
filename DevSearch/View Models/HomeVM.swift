//
//  HomeVM.swift
//  DevSearch
//
//  Created by Mark George on 24/08/2026.
//

import Foundation

@Observable class HomeVM {
    var searchResults: [SearchDeveloper] = []
    
    func searchUsers(query: String, page: Int = 1) async throws {
        var components = URLComponents(
            string: "https://api.github.com/search/users"
        )!

        components.queryItems = [
            URLQueryItem(name: "q", value: query),
            URLQueryItem(name: "per_page", value: "30"),
            URLQueryItem(name: "page", value: "\(page)")
        ]

        var request = URLRequest(url: components.url!)

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

        guard let response = response as? HTTPURLResponse else {
            throw GitHubError.invalidData
        }
        
        switch response.statusCode {
        case 200..<300: break
        case 401:
            throw GitHubError.unauthorized
        case 403, 429:
            throw GitHubError.rateLimitExceeded
        case 404:
            throw GitHubError.notFound(username: query)
        default:
            throw GitHubError.invalidResponse(
                statusCode: response.statusCode
            )
        }

        do {
            let mappedResponse = try JSONDecoder().decode(
                DeveloperSearchResponse.self,
                from: data
            )
            
            if page == 1 {
                searchResults = mappedResponse.items
            } else {
                searchResults.append(contentsOf: mappedResponse.items)
            }
        } catch {
            throw GitHubError.invalidData
        }
    }
}
