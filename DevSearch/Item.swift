//
//  Item.swift
//  DevSearch
//
//  Created by Mark George on 22/08/2026.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
