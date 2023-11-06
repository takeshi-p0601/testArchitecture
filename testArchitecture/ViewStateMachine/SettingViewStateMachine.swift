//
//  SettingViewStateMachine.swift
//  testArchitecture
//
//  Created by Takeshi Komori on 2023/11/06.
//

import Foundation
import Combine

enum SettingViewState: Equatable {
    case Initial
}

enum SettingViewAction {
    case tapAlertButton
}

@MainActor
protocol SettingViewStateMachineable: ObservableObject {
    var state: SettingViewState { get }
    var action: PassthroughSubject<SettingViewAction, Never> { get }
    // corelogic actor
    // gateway commander
    // app
    // router
    var settingViewRouter: SettingViewRouter { get }
}

class SettingViewStateMachine: ObservableObject, SettingViewStateMachineable {
    var state: SettingViewState { self._state }
    let action = PassthroughSubject<SettingViewAction, Never>()
    let settingViewRouter: SettingViewRouter
    
    @Published private var _state: SettingViewState = .Initial
    private var cancellables = Set<AnyCancellable>()
    
    init(settingViewRouter: SettingViewRouter) {
        self.settingViewRouter = settingViewRouter
        
        self.action
            .sink { action in
                switch action {
                case .tapAlertButton:
                    self.settingViewRouter.showFugaAlert()
                }
            }
            .store(in: &cancellables)
    }
}
