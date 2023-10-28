//
//  ProcessMemoryClient.swift
//  testArchitecture
//
//  Created by Takeshi Komori on 2023/10/28.
//

protocol ProcessMemoryClientable {
    func getName() -> String
    func updateName(name: String)
}

class ProcessMemoryClient {
    private let _shared = ProcessMemoryClient()
    private var _name: String = ""
}

extension ProcessMemoryClient: ProcessMemoryClientable {
    func getName() -> String {
        return self._shared._name
    }
    
    func updateName(name: String) {
        self._shared._name = name
    }
}
