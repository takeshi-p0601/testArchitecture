//
//  UserDefaultsClient.swift
//  testArchitecture
//
//  Created by Takeshi Komori on 2023/10/28.
//

import Foundation

enum UserDefaultsKey: String {
    case name = "name"
    case loggedIn = "loggedIn"
}

protocol UserDefaultsClientable {
    func getValue(key: UserDefaultsKey) -> Any?
    func update(value: Any, key: UserDefaultsKey)
    func delete(key: UserDefaultsKey)
}

class UserDefaultsClient: UserDefaultsClientable {
    private let userDefaults: UserDefaults = UserDefaults.standard
    
    func getValue(key: UserDefaultsKey) -> Any? {
        return self.userDefaults.value(forKey: key.rawValue)
    }
    
    func update(value: Any, key: UserDefaultsKey) {
        self.userDefaults.set(value, forKey: key.rawValue)
    }
    
    func delete(key: UserDefaultsKey) {
        self.userDefaults.removeObject(forKey: key.rawValue)
    }
}
