//
//  Developer.swift
//  DevSearch
//
//  Created by Mark George on 24/08/2026.
//

import Foundation

struct SearchDeveloper: Identifiable, Equatable, Codable, Hashable {
    let id: Int
    let login: String
    let avatar_url: String
}

extension SearchDeveloper {
    var pfpURL: URL {
        URL(string: avatar_url)!
    }
}
