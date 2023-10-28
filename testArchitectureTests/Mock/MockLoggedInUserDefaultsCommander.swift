//
//  File.swift
//  testArchitectureTests
//
//  Created by Takeshi Komori on 2023/10/28.
//

@testable import testArchitecture
import Foundation

struct MockLoggedInUserDefaultsCommander: LoggedInUserDefaultsCommandable {
    let client: UserDefaultsClientable
    private let _dummyKey = "dummyLoggedIn"
    
    init(client: UserDefaultsClientable = UserDefaultsClient()) {
        self.client = client
        // 消しておく
        UserDefaults.standard.removeObject(forKey: self._dummyKey)
    }
    
    func getCommand() -> Bool? {
        return UserDefaults.standard.object(forKey: self._dummyKey) as? Bool ?? false
    }
    
    func updateCommand(loggedIn: Bool) {
        UserDefaults.standard.setValue(loggedIn, forKey: self._dummyKey)
    }
    
    func deleteCommand() {
        // 必要になったら対応
    }
}

extension MockLoggedInUserDefaultsCommander {
    mutating func updateDummyLoggedIn() {
    }
}
