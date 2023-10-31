//
//  EntryPointViewStateMachine.swift
//  testArchitecture
//
//  Created by Takeshi Komori on 2023/10/31.
//

import Foundation
import Combine

enum EntryPointViewState: Equatable {
    case Initial
}

enum EntryPointViewAction {
    case onAppear
}

@MainActor
protocol EntryPointViewStateMachineable: ObservableObject {
    var state: EntryPointViewState { get }
    var action: PassthroughSubject<EntryPointViewAction, Never> { get }
    var loggedInUserDefaultsCommander: LoggedInUserDefaultsCommandable { get }
}

class EntryPointViewStateMachine: ObservableObject, EntryPointViewStateMachineable {
    var state: EntryPointViewState { _state }
    let action = PassthroughSubject<EntryPointViewAction, Never>()
    
    let loggedInUserDefaultsCommander: LoggedInUserDefaultsCommandable
    let rootViewChangeNotifier: RootViewChangeNotifier
    
    @Published private var _state: EntryPointViewState = .Initial
    private var cancellables = Set<AnyCancellable>()
    
    init(loggedInUserDefaultsCommander: LoggedInUserDefaultsCommandable,
         rootViewChangeNotifier: RootViewChangeNotifier) {
        self.loggedInUserDefaultsCommander = loggedInUserDefaultsCommander
        self.rootViewChangeNotifier = rootViewChangeNotifier
        
        self.action
            .sink { action in
                switch action {
                case .onAppear:
                    if let loggedIn = loggedInUserDefaultsCommander.getCommand() {
                        self.rootViewChangeNotifier
                            .action
                            .send(.splashAppeared(loggedIn: loggedIn))
                    } else {
                        self.rootViewChangeNotifier
                            .action
                            .send(.splashAppeared(loggedIn: false))
                    }
                }
                
            }
            .store(in: &cancellables)
    }
}
