//
//  PersistenceError.swift
//  DevSearch
//
//  Created by Mark George on 24/08/2026.
//

import Foundation


nonisolated enum PersistenceError: AppError {
    case fetchFailed
    case saveFailed
    case deleteFailed
    case invalidData

    var message: String {
        switch self {
        case .fetchFailed:
            "Unable to load saved developers."
        case .saveFailed:
            "Unable to save the developer."
        case .deleteFailed:
            "Unable to delete the developer."
        case .invalidData:
            "The saved data is invalid."
        }
    }
}
