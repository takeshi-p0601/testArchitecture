//
//  MainViewRouterTests.swift
//  testArchitectureTests
//
//  Created by Takeshi Komori on 2023/11/06.
//

import XCTest
@testable import testArchitecture

final class MainViewRouterTests: XCTestCase {
    @MainActor func testActivateSettingView() {
        let mainViewRouter = MainViewRouter()
        
        // activateする前
        XCTAssertEqual(mainViewRouter.isSettingViewActivated, false)
        XCTAssertNil(mainViewRouter.activatedSettingView)
        
        // activate後
        mainViewRouter.activateSettingView()
        XCTAssertEqual(mainViewRouter.isSettingViewActivated, true)
        XCTAssertNotNil(mainViewRouter.activatedSettingView)
    }
    
    @MainActor func testActivateHogeView() {
        let mainViewRouter = MainViewRouter()
        
        // activateする前
        XCTAssertEqual(mainViewRouter.isHogeViewActivated, false)
        XCTAssertNil(mainViewRouter.activatedHogeView)
        
        // activate後
        mainViewRouter.activateHogeView()
        XCTAssertEqual(mainViewRouter.isHogeViewActivated, true)
        XCTAssertNotNil(mainViewRouter.activatedHogeView)
    }
}
