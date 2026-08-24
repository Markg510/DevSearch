//
//  Repository.swift
//  DevSearch
//
//  Created by Mark George on 24/08/2026.
//

import Foundation

struct Repository: Identifiable, Codable {
    let id: Int
    let name: String
    let htmlURL: String
    let description: String?
    let language: ProgrammingLanguage?
    let stargazersCount: Int
    let forksCount: Int

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case htmlURL = "html_url"
        case description
        case language
        case stargazersCount = "stargazers_count"
        case forksCount = "forks_count"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        htmlURL = try container.decode(String.self, forKey: .htmlURL)
        description = try container.decodeIfPresent(String.self, forKey: .description)

        language = try? container.decode(
            ProgrammingLanguage.self,
            forKey: .language
        )

        stargazersCount = try container.decode(Int.self, forKey: .stargazersCount)
        forksCount = try container.decode(Int.self, forKey: .forksCount)
    }
}
