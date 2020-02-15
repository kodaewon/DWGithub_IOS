//
//  Language.swift
//  DWGithub
//
//  Created by 고대원 on 2020/02/14.
//  Copyright © 2020 고대원. All rights reserved.
//

enum Language: String, Encodable {
    case JavaScript = "JavaScript"
    case Python = "Python"
    case Java = "Java"
    case Go = "Go"
    case Cpp = "C++"
    case Ruby = "Ruby"
    case TypeScript = "TypeScript"
    case PHP = "PHP"
    case Csarp = "C#"
    case C = "C"
    case Shell = "Shell"
    case Scala = "Scala"
    case Rust = "Rust"
    case Swift = "Swift"
    case Dart = "Dart"
    case Kotlin = "Kotlin"
    case ObjectiveC = "ObjectiveC"
    case None = "None"
}

extension Language: CustomStringConvertible {
    var description: String {
        return self.rawValue
    }
}

// MARK: - iamge
extension Language {
    var image: String {
        switch self {
        case .JavaScript:
            return "js"
        case .Python:
            return "py"
        case .Java:
            return "java"
        case .Go:
            return "go"
        case .Cpp:
            return "c++"
        case .Ruby:
            return "ruby"
        case .TypeScript:
            return "ts"
        case .PHP:
            return "php"
        case .Csarp:
            return "c#"
        case .C:
            return "js"
        case .Shell:
            return "js"
        case .Scala:
            return "js"
        case .Rust:
            return "js"
        case .Swift:
            return "swift"
        case .Dart:
            return "js"
        case .Kotlin:
            return "js"
        case .ObjectiveC:
            return "objective"
        case .None:
            return "search"
        }
    }
}
