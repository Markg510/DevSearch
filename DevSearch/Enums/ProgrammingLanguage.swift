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
    case tsql
    case apacheConf
    case objectiveC
    case ejs
    case jupyterNotebook
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
        case .tsql: "T-SQL"
        case .apacheConf: "ApacheConf"
        case .objectiveC: "Objective-C"
        case .ejs: "EJS"
        case .jupyterNotebook: "Jupyter Notebook"
        case .lua: "Lua"
        }
    }

    /// We use official GitHub language colors here.
    /// 3l4an kda msh 7atethom fl assets
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
        case .tsql: .init(hex: "3178C6")
        case .apacheConf: .init(hex: "D22128")
        case .objectiveC: .init(hex: "438EFF")
        case .ejs: .init(hex: "A91E50")
        case .jupyterNotebook: .init(hex: "DA5B0B")
        case .lua: .init(hex: "000080")
        }
    }
}

extension ProgrammingLanguage: Codable {
    init(from decoder: Decoder) throws {
        let value = try decoder.singleValueContainer().decode(String.self)

        switch value {
        case "JavaScript": self = .javascript
        case "TypeScript": self = .typescript
        case "Python": self = .python
        case "Java": self = .java
        case "C#": self = .cSharp
        case "C++": self = .cpp
        case "C": self = .c
        case "Assembly": self = .assembly
        case "Go": self = .go
        case "Rust": self = .rust
        case "PHP": self = .php
        case "Swift": self = .swift
        case "Kotlin": self = .kotlin
        case "Ruby": self = .ruby
        case "Dart": self = .dart
        case "Shell": self = .shell
        case "HTML": self = .html
        case "CSS": self = .css
        case "Vue": self = .vue
        case "R": self = .r
        case "Scala": self = .scala
        case "TSQL": self = .tsql
        case "ApacheConf": self = .apacheConf
        case "Objective-C": self = .objectiveC
        case "EJS": self = .ejs
        case "Jupyter Notebook": self = .jupyterNotebook
        case "Lua": self = .lua

        default:
            throw DecodingError.dataCorruptedError(
                in: try decoder.singleValueContainer(),
                debugDescription: "Unsupported GitHub language: \(value)"
            )
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(title)
    }
}
