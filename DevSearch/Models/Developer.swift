//
//  Developer.swift
//  DevSearch
//
//  Created by Mark George on 24/08/2026.
//

import Foundation

struct Developer: Identifiable, Codable, Equatable {
    let id: Int
    let login: String
    let name: String?
    let avatarURL: String
    let htmlURL: String
    let bio: String?
    let location: String?
    let blog: String?
    let email: String?
    
    let publicRepos: Int
    let followers: Int
    let following: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case login
        case name
        case avatarURL = "avatar_url"
        case htmlURL = "html_url"
        case bio
        case location
        case blog
        case email
        case publicRepos = "public_repos"
        case followers
        case following
    }
}

extension Developer {
    var pfpURL: URL {
        URL(string: avatarURL)!
    }
}
