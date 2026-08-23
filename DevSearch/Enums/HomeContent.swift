//
//  HomeContent.swift
//  DevSearch
//
//  Created by Mark George on 23/08/2026.
//

import Foundation

enum HomeContent: String {
    case featured
    case bookmarked
    case previousResults
    
    var title: String {
        switch self {
        case .featured: "Featured"
        case .bookmarked: "Bookmarked"
        case .previousResults: "Previous Results"
        }
    }
    
    var description: String {
        switch self {
        case .featured: "Handpicked Developers"
        case .bookmarked: "Your saved developers"
        case .previousResults: "Your latest search results"
        }
    }
    
    var icon: String {
        switch self {
        case .featured: "star.fill"
        case .bookmarked: "bookmark.fill"
        case .previousResults: "clock.fill"
        }
    }
}
