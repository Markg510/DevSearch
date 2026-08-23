//
//  Int+Extensions.swift
//  DevSearch
//
//  Created by Mark George on 23/08/2026.
//

import Foundation

extension Int {
    func formattedValue() -> String {
        if self > 999 {
            "\(self / 1_000)k"
        } else {
            String(self)
        }
    }
}
