//
//  LoginViewStateMachine.swift
//  testArchitecture
//
//  Created by Takeshi Komori on 2023/10/28.
//

import Foundation
import Combine

struct LoginViewStateParameters: Equatable {
    var name: String = ""
    var password: String = ""
}

enum LoginViewState: Equatable {
    case None
    case Inputting(parameters: LoginViewStateParameters)
    case Prepared(parameters: LoginViewStateParameters)
    case UnreasonableValue(parameters: LoginViewStateParameters)
    case Loading(parameters: LoginViewStateParameters)
    case Retryable(parameters: LoginViewStateParameters)
    case LoginCompleted
}

enum LoginViewAction {
    case tapLoginButton
    case inputName(name: String)
    case inputPassword(password: String)
    case dismissKeyboard
}

@MainActor
protocol LoginViewStateMachineable: ObservableObject {
    var state: LoginViewState { get }
    var action: PassthroughSubject<LoginViewAction, Never> { get }
    // corelogic actor
    var nameValueChecker: NameValueCheckable { get }
    var passwordValueChecker: PasswordValueCheckable { get }
    // gateway commander
    var postLoginAPICommander: PostLoginAPICommandable { get }
    var loggedInUserDefaultsCommander: LoggedInUserDefaultsCommandable { get }
}

class LoginViewStateMachine: ObservableObject, LoginViewStateMachineable {
    var state: LoginViewState { _state }
    let action = PassthroughSubject<LoginViewAction, Never>()
    let nameValueChecker: NameValueCheckable
    let passwordValueChecker: PasswordValueCheckable
    let postLoginAPICommander: PostLoginAPICommandable
    let loggedInUserDefaultsCommander: LoggedInUserDefaultsCommandable
    
    @Published private var _state: LoginViewState = .None
    private var cancellables = Set<AnyCancellable>()
    private var currentStatesParameters: LoginViewStateParameters {
        switch _state {
        case .None: return .init()
        case .Inputting(let parameters): return parameters
        case .Prepared(let parameters): return parameters
        case .UnreasonableValue(let parameters): return parameters
        case .Loading(let parameters): return parameters
        case .Retryable(let parameters): return parameters
        case .LoginCompleted: return .init()
        }
    }
    
    init(nameValueChecker: NameValueChecker,
         passwordValueChecker: PasswordValueChecker,
         postLoginAPICommander: PostLoginAPICommandable,
         loggedInUserDefaultsCommander: LoggedInUserDefaultsCommandable) {
        self.nameValueChecker = nameValueChecker
        self.passwordValueChecker = passwordValueChecker
        self.postLoginAPICommander = postLoginAPICommander
        self.loggedInUserDefaultsCommander = loggedInUserDefaultsCommander
        
        self.observeAction()
    }
    
    private func observeAction() {
        self.action
            .sink { action in
                switch action {
                case .tapLoginButton:
                    // ボタンを活性非活性にするかで変わる
                    // 入力した内容で、ボタンが非活性になるとする
                    Task {
                        let name = self.currentStatesParameters.name
                        let password = self.currentStatesParameters.password
                        let postLoginAPIResult = await self.postLoginAPICommander.command(name: name, password: password)
                        
                        if postLoginAPIResult.success {
                            self.loggedInUserDefaultsCommander.updateCommand(loggedIn: true)
                            self._state = .LoginCompleted
                        } else {
                            self._state = .Retryable(parameters: self.currentStatesParameters)
                        }
                    }
                    
                case .inputName(let name):
                    var newParameters = self.currentStatesParameters
                    newParameters.name = name
                    self._state = .Inputting(parameters: newParameters)
                    
                case .inputPassword(let password):
                    var newParameters = self.currentStatesParameters
                    newParameters.password = password
                    self._state = .Inputting(parameters: newParameters)
                    
                case .dismissKeyboard:
                    if case .Inputting(let parameters) = self._state {
                        let nameValidateResult = self.nameValueChecker.check(name: parameters.name)
                        
                        switch nameValidateResult {
                        case .fail(let reason):
                            switch reason {
                            case .containsInvalidCharacter:
                                self._state = .UnreasonableValue(parameters: parameters)
                            case .notEnoughCharacterCount:
                                self._state = .UnreasonableValue(parameters: parameters)
                            }
                            // ここでreturnさせ、パスワードバリデーションに進めないようにする
                            return
                        case .success: break
                        }
                        
                        let passwordValidateResult = self.passwordValueChecker.check(password: parameters.password)
                        
                        switch passwordValidateResult {
                        case .fail(let reason):
                            switch reason {
                            case .containsInvalidCharacter:
                                self._state = .UnreasonableValue(parameters: parameters)
                            case .notEnoughCharacterCount:
                                self._state = .UnreasonableValue(parameters: parameters)
                            }
                        case .success:
                            self._state = .Prepared(parameters: parameters)
                        }
                    }
                }
            }
            .store(in: &cancellables)
    }
}
