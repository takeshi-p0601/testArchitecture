//
//  EnryPointViewBuilder.swift
//  testArchitecture
//
//  Created by Takeshi Komori on 2023/10/31.
//

struct EntryPointViewBuilder {
    @MainActor func build() -> EntryPointView {
        let loggedInUserDefaultsCommander = LoggedInUserDefaultsCommander(client: UserDefaultsClient())
        let rootViewChanger = RootViewChanger.shared
        let stateMachine = EntryPointViewStateMachine(loggedInUserDefaultsCommander: loggedInUserDefaultsCommander,
                                                      rootViewChanger: rootViewChanger)
        return EntryPointView(entryPointViewStateMachine: stateMachine)
    }
}
