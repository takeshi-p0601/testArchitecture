//
//  NameUserDefaultsCommander.swift
//  testArchitecture
//
//  Created by Takeshi Komori on 2023/10/28.
//

protocol NameUserDefaultsCommandable {
    var client: UserDefaultsClientable { get }
    func getCommand() -> String?
    func updateCommand(name: String)
}

struct NameUserDefaultsCommander: NameUserDefaultsCommandable {
    var client: UserDefaultsClientable
    
    func getCommand() -> String? {
        return self.client.getValue(key: .name) as? String
    }
    
    func updateCommand(name: String) {
        self.client.update(value: name, key: .name)
    }
}
