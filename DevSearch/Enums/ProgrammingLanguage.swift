//
//  ProgrammingLanguage.swift
//  DevSearch
//
//  Created by Mark George on 23/08/2026.
//

import SwiftUI

enum ProgrammingLanguage: CaseIterable, Identifiable {
    case javascript
    case typescript
    case python
    case java
    case cSharp
    case cpp
    case c
    case assembly
    case go
    case rust
    case php
    case swift
    case kotlin
    case ruby
    case dart
    case shell
    case html
    case css
    case vue
    case r
    case scala
    case lua
    
    var id: Self { self }
}

extension ProgrammingLanguage {
    var title: String {
        switch self {
        case .javascript: "JavaScript"
        case .typescript: "TypeScript"
        case .python: "Python"
        case .java: "Java"
        case .cSharp: "C#"
        case .cpp: "C++"
        case .c: "C"
        case .assembly: "Assembly"
        case .go: "Go"
        case .rust: "Rust"
        case .php: "PHP"
        case .swift: "Swift"
        case .kotlin: "Kotlin"
        case .ruby: "Ruby"
        case .dart: "Dart"
        case .shell: "Shell"
        case .html: "HTML"
        case .css: "CSS"
        case .vue: "Vue"
        case .r: "R"
        case .scala: "Scala"
        case .lua: "Lua"
        }
    }
    
    /// We use official GitHub language colors here.
    /// 3l4an kda msh 7atethom fl assets.
    var color: Color {
        switch self {
        case .javascript: .init(hex: "F1E05A")
        case .typescript: .init(hex: "3178C6")
        case .python: .init(hex: "3572A5")
        case .java: .init(hex: "B07219")
        case .cSharp: .init(hex: "178600")
        case .cpp: .init(hex: "F34B7D")
        case .c: .init(hex: "555555")
        case .assembly: .init(hex: "6E4C13")
        case .go: .init(hex: "00ADD8")
        case .rust: .init(hex: "DEA584")
        case .php: .init(hex: "4F5D95")
        case .swift: .init(hex: "F05138")
        case .kotlin: .init(hex: "A97BFF")
        case .ruby: .init(hex: "701516")
        case .dart: .init(hex: "00B4AB")
        case .shell: .init(hex: "89E051")
        case .html: .init(hex: "E34C26")
        case .css: .init(hex: "563D7C")
        case .vue: .init(hex: "41B883")
        case .r: .init(hex: "198CE7")
        case .scala: .init(hex: "DC322F")
        case .lua: .init(hex: "000080")
        }
    }
}
