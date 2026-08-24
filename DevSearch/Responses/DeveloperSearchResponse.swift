//
//  DeveloperSearchResponse.swift
//  DevSearch
//
//  Created by Mark George on 24/08/2026.
//

import Foundation

struct DeveloperSearchResponse: Codable {
    let totalCount: Int
    let incompleteResults: Bool
    let items: [SearchDeveloper]

    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
        case items
    }
}
