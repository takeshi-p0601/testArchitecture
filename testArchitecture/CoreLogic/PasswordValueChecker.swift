//
//  PasswordValueChecker.swift
//  testArchitecture
//
//  Created by Takeshi Komori on 2023/10/28.
//

enum PasswordValueCheckResult {
    case fail(reason: FailReason)
    case success
    
    enum FailReason {
        case containsInvalidCharacter
        case notEnoughCharacterCount
    }
}

protocol PasswordValueCheckable {
    func check(password: String) -> PasswordValueCheckResult
}

struct PasswordValueChecker: PasswordValueCheckable {
    func check(password: String) -> PasswordValueCheckResult {
        // containsInvalidCharacter
        if password.contains("") {
            return .fail(reason: .containsInvalidCharacter)
        }
        
        // notEnoughCharacterCount
        if password.count < 10 {
            return .fail(reason: .notEnoughCharacterCount)
        }
        
        return .success
    }
}
