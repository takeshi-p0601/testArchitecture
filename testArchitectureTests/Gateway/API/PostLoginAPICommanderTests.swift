//
//  PostLoginAPICommanderTests.swift
//  testArchitectureTests
//
//  Created by Takeshi Komori on 2023/10/28.
//

import XCTest
@testable import testArchitecture

final class PostLoginAPICommanderTests: XCTestCase {
    func testCommandForSuccess() async {
        let dummyResult = PostLoginAPIResponse(success: true)
        let postLoginAPICommander = PostLoginAPICommander(client: MockAPIClient<PostLoginRequest>(dummyResult: dummyResult))
        let result = await postLoginAPICommander.command(name: "name", password: "password")
        XCTAssertEqual(result.success, true)
    }
    
    func testCommandForFail() async {
        let dummyResult = PostLoginAPIResponse(success: false)
        let postLoginAPICommander = PostLoginAPICommander(client: MockAPIClient<PostLoginRequest>(dummyResult: dummyResult))
        let result = await postLoginAPICommander.command(name: "name", password: "password")
        XCTAssertEqual(result.success, false)
    }
}
