//
//  EnryPointViewBuilder.swift
//  testArchitecture
//
//  Created by Takeshi Komori on 2023/10/31.
//

struct EnryPointViewBuilder {
    @MainActor func build() -> EntryPointView {
        let loggedInUserDefaultsCommander = LoggedInUserDefaultsCommander(client: UserDefaultsClient())
        let rootViewChangeNotifier = RootViewChangeNotifier.shared
        let stateMachine = EntryPointViewStateMachine(loggedInUserDefaultsCommander: loggedInUserDefaultsCommander,
                                                      rootViewChangeNotifier: rootViewChangeNotifier)
        return EntryPointView(entryPointViewStateMachine: stateMachine)
    }
}
