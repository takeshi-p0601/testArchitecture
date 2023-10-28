//
//  NameProcessMemoryCommander.swift
//  testArchitecture
//
//  Created by Takeshi Komori on 2023/10/28.
//

protocol NameProcessMemoryCommandable {
    var client: ProcessMemoryClientable { get }
    func updateCommand(name: String)
    func getCommand() -> String
}

struct NameProcessMemoryCommander: NameProcessMemoryCommandable {
    var client: ProcessMemoryClientable
    
    func updateCommand(name: String) {
        self.client.updateName(name: name)
    }
    
    func getCommand() -> String {
        return self.client.getName()
    }
}
