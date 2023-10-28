//
//  LoginViewStateMachineTests.swift
//  testArchitectureTests
//
//  Created by Takeshi Komori on 2023/10/28.
//

import XCTest

final class LoginViewStateMachineTests: XCTestCase {
    func testTapLoginButton() {
        // ボタンタップイベント発火
        
        // API実行
        
        // 失敗するとStateとして、Retryableを返す
        
        // 成功するとStateとして、Completeを返す
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
