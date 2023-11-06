//
//  RootViewChangeNotifier.swift
//  testArchitecture
//
//  Created by Takeshi Komori on 2023/10/31.
//

import Foundation
import Combine

enum RootViewType {
    case loginView(LoginView)
    case mainView(MainView)
}

enum RootViewChangeAction {
    case splashAppeared(loggedIn: Bool)
    case succeedLogin
}

@MainActor
class RootViewChanger: ObservableObject {
    static let shared: RootViewChanger = .init()
    
    var rootViewType: RootViewType? { self._rootViewType }
    let action = PassthroughSubject<RootViewChangeAction, Never>()
    
    @Published private var _rootViewType: RootViewType? = nil
    private var cancellables = Set<AnyCancellable>()
    
    private init() {
        self.action
            .sink { action in
                switch action {
                case .splashAppeared(let loggedIn):
                    if loggedIn {
                        self._rootViewType = .mainView(MainViewBuilder().build())
                    } else {
                        self._rootViewType = .loginView(LoginViewBuilder().build())
                    }
                case .succeedLogin:
                    self._rootViewType = .mainView(MainViewBuilder().build())
                }
            }
            .store(in: &cancellables)
    }
}
