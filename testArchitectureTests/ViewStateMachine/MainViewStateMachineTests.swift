//
//  MainViewStateMachineTests.swift
//  testArchitectureTests
//
//  Created by Takeshi Komori on 2023/11/06.
//

import XCTest
@testable import testArchitecture

final class MainViewStateMachineTests: XCTestCase {
    @MainActor func testTapMeButton() {
        let mainViewRouter = MainViewRouter()
        let mainViewStateMachine = MainViewStateMachine(rootViewChanger: RootViewChanger.shared,
                                                        mainViewRouter: mainViewRouter)
        // 遷移イベント発生してないこと確認
        XCTAssertEqual(mainViewRouter.settingView.activated, false)
        XCTAssertNil(mainViewRouter.settingView.itself)
        
        // ボタンタップ
        mainViewStateMachine.action.send(.tapMeButton)
        
        // 遷移イベント発火していること確認
        XCTAssertEqual(mainViewRouter.settingView.activated, true)
        XCTAssertNotNil(mainViewRouter.settingView.itself)
    }
    
    @MainActor func testTapHogeButton() {
        let mainViewRouter = MainViewRouter()
        let mainViewStateMachine = MainViewStateMachine(rootViewChanger: RootViewChanger.shared,
                                                        mainViewRouter: mainViewRouter)
        // 遷移イベント発生してないこと確認
        XCTAssertEqual(mainViewRouter.hogeView.activated, false)
        XCTAssertNil(mainViewRouter.hogeView.itself)
        
        // ボタンタップ
        mainViewStateMachine.action.send(.tapHogeButton)
        
        // 遷移イベント発火していること確認
        XCTAssertEqual(mainViewRouter.hogeView.activated, true)
        XCTAssertNotNil(mainViewRouter.hogeView.itself)
    }
}
