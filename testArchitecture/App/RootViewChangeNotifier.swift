//
//  RootViewChangeNotifier.swift
//  testArchitecture
//
//  Created by Takeshi Komori on 2023/10/31.
//

import Foundation
import Combine

enum RootViewType {
    case entryPointView
    case loginView
    case mainView
}

enum RootViewChangeAction {
    case splashAppeared(loggedIn: Bool)
    case succeedLogin
}

class RootViewChangeNotifier: ObservableObject {
    static let shared: RootViewChangeNotifier = .init()
    
    var rootViewType: RootViewType { self._rootViewType }
    let action = PassthroughSubject<RootViewChangeAction, Never>()
    
    @Published private var _rootViewType: RootViewType = .entryPointView
    private var cancellables = Set<AnyCancellable>()
    
    private init() {
        self.action
            .sink { action in
                switch action {
                case .splashAppeared(let loggedIn):
                    if loggedIn {
                        self._rootViewType = .mainView
                    } else {
                        self._rootViewType = .loginView
                    }
                case .succeedLogin:
                    self._rootViewType = .mainView
                }
            }
            .store(in: &cancellables)
    }
}
