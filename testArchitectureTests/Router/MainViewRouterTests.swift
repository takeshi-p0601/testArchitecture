//
//  MainViewRouterTests.swift
//  testArchitectureTests
//
//  Created by Takeshi Komori on 2023/11/06.
//

import XCTest
@testable import testArchitecture

final class MainViewRouterTests: XCTestCase {
    func testActivateSettingView() {
        let mainViewRouter = MainViewRouter()
        
        // activateする前
        XCTAssertEqual(mainViewRouter.settingView.activated, false)
        XCTAssertNil(mainViewRouter.settingView.itself)
        
        // activate後
        mainViewRouter.activateSettingView()
        XCTAssertEqual(mainViewRouter.settingView.activated, true)
        XCTAssertNotNil(mainViewRouter.settingView.itself)
    }
    
    func testActivateHogeView() {
        let mainViewRouter = MainViewRouter()
        
        // activateする前
        XCTAssertEqual(mainViewRouter.hogeView.activated, false)
        XCTAssertNil(mainViewRouter.hogeView.itself)
        
        // activate後
        mainViewRouter.activateHogeView()
        XCTAssertEqual(mainViewRouter.hogeView.activated, true)
        XCTAssertNotNil(mainViewRouter.hogeView.itself)
    }
}
