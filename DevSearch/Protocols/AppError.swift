//
//  AppError.swift
//  DevSearch
//
//  Created by Mark George on 24/08/2026.
//

import Foundation

nonisolated protocol AppError: Error, Equatable, Sendable {
    var message: String { get }
}
