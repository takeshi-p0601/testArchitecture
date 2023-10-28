//
//  LoginViewStateMachineTests.swift
//  testArchitectureTests
//
//  Created by Takeshi Komori on 2023/10/28.
//

import XCTest
@testable import testArchitecture

final class LoginViewStateMachineTests: XCTestCase {
    
    @MainActor func testTapLoginButton() {
        XCTContext.runActivity(named: "ボタン押下時、ログインリクエストに失敗した場合") { _ in
            let mockPostLoginAPICommander = MockPostLoginAPICommander(dummyResult: PostLoginAPIResponse(success: false))
            let mockLoggedInUserDefaultsCommander = MockLoggedInUserDefaultsCommander()
            let loginViewStateMachine = LoginViewStateMachine(nameValueChecker: NameValueChecker(),
                                                              passwordValueChecker: PasswordValueChecker(),
                                                              postLoginAPICommander: mockPostLoginAPICommander,
                                                              loggedInUserDefaultsCommander: mockLoggedInUserDefaultsCommander)
            let dummyStateParameters = LoginViewStateParameters(name: "1234567890", password: "password12")
            // 妥当チェック済みの名前を入力"
            loginViewStateMachine.action.send(.inputName(name: dummyStateParameters.name))
            // 妥当チェック済みのパスワードを入力"
            loginViewStateMachine.action.send(.inputPassword(password: dummyStateParameters.password))
            // キーボードを閉じる
            loginViewStateMachine.action.send(.dismissKeyboard)
            // StateがPreparedになっていることを確認
            XCTAssertEqual(loginViewStateMachine.state, .Prepared(parameters: dummyStateParameters))
            // ボタンタップイベント発火
            loginViewStateMachine.action.send(.tapLoginButton)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                // Retryableに変更していること確認
                XCTAssertEqual(loginViewStateMachine.state, .Retryable(parameters: dummyStateParameters))
                XCTAssertFalse(mockLoggedInUserDefaultsCommander.getCommand()!)
            }
        }
        
        XCTContext.runActivity(named: "ボタン押下時、ログインリクエストに成功した場合") { _ in
            let mockPostLoginAPICommander = MockPostLoginAPICommander(dummyResult: PostLoginAPIResponse(success: true))
            let mockLoggedInUserDefaultsCommander = MockLoggedInUserDefaultsCommander()
            let loginViewStateMachine = LoginViewStateMachine(nameValueChecker: NameValueChecker(),
                                                              passwordValueChecker: PasswordValueChecker(),
                                                              postLoginAPICommander: mockPostLoginAPICommander,
                                                              loggedInUserDefaultsCommander: mockLoggedInUserDefaultsCommander)
            let dummyStateParameters = LoginViewStateParameters(name: "0123456789", password: "password21")
            // 妥当チェック済みの名前を入力"
            loginViewStateMachine.action.send(.inputName(name: dummyStateParameters.name))
            // 妥当チェック済みのパスワードを入力"
            loginViewStateMachine.action.send(.inputPassword(password: dummyStateParameters.password))
            // キーボードを閉じる
            loginViewStateMachine.action.send(.dismissKeyboard)
            // StateがPreparedになっていることを確認
            XCTAssertEqual(loginViewStateMachine.state, .Prepared(parameters: dummyStateParameters))
            // ボタンタップイベント発火
            loginViewStateMachine.action.send(.tapLoginButton)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                // StateがCompleteになっていることを確認
                XCTAssertEqual(loginViewStateMachine.state, .LoginCompleted)
                XCTAssertTrue(mockLoggedInUserDefaultsCommander.getCommand()!)
            }
        }
    }
    
    func testInputName() {
        // 名前を入力イベント発火
        
        // StateがInputtingになり、parameterに付与されているか
    }
    
    func testInputPassword() {
        // パスワードを入力イベント発火
        
        // StateがInputtingになり、parameterに付与されているか
    }
    
    func testDismissKeyboard() {
        // キーボードディスミスイベント発火
        
        // 名前チェックして、XXだったらXXする
        
        // 名前チェック通過後、パスワードチェックして、XXだったらXXする
    }
}
