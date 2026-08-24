//
//  ViewMode.swift
//  DevSearch
//
//  Created by Mark George on 24/08/2026.
//

import SwiftUI

import SwiftUI

enum ViewMode {
    case loading(label: String)
    case failure(error: Error)
    case success
    
    var isLoading: Bool {
        if case .loading(_) = self {
            true
        } else {
            false
        }
    }
    
    var loadingLabel: String {
        return if case .loading(let label) = self {
            label
        } else {
            ""
        }
    }
    
    @ViewBuilder
    var errorView: some View {
        if case .failure(let error) = self {
            let errorMessage = if let err = error as? (any AppError) {
                err.message
            } else {
                error.localizedDescription
            }
            
            ErrorView(errorDescription: errorMessage)
        }
    }
}
