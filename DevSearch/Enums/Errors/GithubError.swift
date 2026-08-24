//
//  GithubError.swift
//  DevSearch
//
//  Created by Mark George on 24/08/2026.
//

import Foundation

nonisolated enum GitHubError: AppError {
    case invalidUsername
    case unableToComplete(URLError.Code? = nil)
    case invalidResponse(statusCode: Int)
    case invalidData
    case rateLimitExceeded
    case notFound(username: String)
    case unauthorized

    var message: String {
        return switch self {
        case .invalidUsername:
            "The entered username is invalid."
        case .unableToComplete:
            "Unable to complete request. Please check your connection."
        case .invalidResponse(let statusCode):
            "Received unexpected server response (\(statusCode))."
        case .invalidData:
            "The data returned by GitHub could not be processed."
        case .rateLimitExceeded:
            "GitHub API rate limit exceeded. Please wait a bit."
        case .notFound(let username):
            "No GitHub profile found for '\(username)'."
        case .unauthorized:
            "Authentication failed. Check your API token."
        }
    }
}
