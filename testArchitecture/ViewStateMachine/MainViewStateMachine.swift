//
//  MainViewStateMachine.swift
//  testArchitecture
//
//  Created by Takeshi Komori on 2023/11/03.
//

import Foundation
import Combine

enum MainViewState: Equatable {
    case Initial
}

enum MainViewAction {
    case onAppear
    case tapMeButton
    case tapHogeButton
}

struct MainViewNavigateHogeViewParameters {
    var shouldNavigate: Bool { self._shouldNavigate }
    private var _shouldNavigate: Bool = false
    var name: String { _name }
    private var _name: String = ""
}

@MainActor
protocol MainViewStateMachineable: ObservableObject {
    var state: MainViewState { get }
    var action: PassthroughSubject<MainViewAction, Never> { get }
    // corelogic actor
    // gateway commander
    // app
    var rootViewChanger: RootViewChanger { get }
    // router
    var mainViewRouter: MainViewRouter { get }
}

class MainViewStateMachine: ObservableObject, MainViewStateMachineable {
    var state: MainViewState { self._state }
    let action = PassthroughSubject<MainViewAction, Never>()
    let rootViewChanger: RootViewChanger
    let mainViewRouter: MainViewRouter
    
    @Published private var _state: MainViewState = .Initial
    private var cancellables = Set<AnyCancellable>()
    
    init(rootViewChanger: RootViewChanger,
         mainViewRouter: MainViewRouter) {
        self.rootViewChanger = rootViewChanger
        self.mainViewRouter = mainViewRouter
        
        self.action
            .sink { action in
                switch action {
                case .onAppear: break
                case .tapMeButton:
                    self.mainViewRouter.activateSettingView()
                case .tapHogeButton:
                    self.mainViewRouter.activateHogeView()
                }
            }
            .store(in: &cancellables)
    }
}
