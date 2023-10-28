//
//  LoggedInUserDefaultsCommander.swift
//  testArchitecture
//
//  Created by Takeshi Komori on 2023/10/28.
//

protocol LoggedInUserDefaultsCommandable {
    var client: UserDefaultsClientable { get }
    func getCommand() -> Bool?
    func updateCommand(loggedIn: Bool)
    func deleteCommand()
}

struct LoggedInUserDefaultsCommander: LoggedInUserDefaultsCommandable {
    let client: UserDefaultsClientable
    
    init(client: UserDefaultsClientable) {
        self.client = client
    }
    
    func getCommand() -> Bool? {
        if let loggedIn = self.client.getValue(key: .loggedIn) as? Bool {
            return loggedIn
        }
        return false
    }
    
    func updateCommand(loggedIn: Bool) {
        self.client.update(value: loggedIn, key: .loggedIn)
    }
    
    func deleteCommand() {
        self.client.delete(key: .loggedIn)
    }
}
