//
//  CachedDeveloper.swift
//  DevSearch
//
//  Created by Mark George on 24/08/2026.
//

import Foundation
import SwiftData

@Model
final class CachedDeveloper: Equatable {
    @Attribute(.unique)
    var id: Int

    var avatarURL: String
    var login: String

    init(
        id: Int,
        avatarURL: String,
        login: String
    ) {
        self.id = id
        self.avatarURL = avatarURL
        self.login = login
    }
}
