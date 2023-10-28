//
//  NameValueChecker.swift
//  testArchitecture
//
//  Created by Takeshi Komori on 2023/10/28.
//

enum NameValueCheckResult {
    case fail(reason: FailReason)
    case success
    
    enum FailReason {
        case containsInvalidCharacter
        case notEnoughCharacterCount
    }
}

protocol NameValueCheckable {
    func check(name: String) -> NameValueCheckResult
}

struct NameValueChecker: NameValueCheckable {
    func check(name: String) -> NameValueCheckResult {
        // containsInvalidCharacter
        if name.contains("") {
            return .fail(reason: .containsInvalidCharacter)
        }
        
        // notEnoughCharacterCount
        if name.count < 10 {
            return .fail(reason: .notEnoughCharacterCount)
        }
        
        return .success
    }
}


