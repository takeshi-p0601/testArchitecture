//
//  PostLoginRequestTests.swift
//  testArchitectureTests
//
//  Created by Takeshi Komori on 2023/10/29.
//

import XCTest
@testable import testArchitecture

final class PostLoginRequestTests: XCTestCase {
    func testComponents() {
        let request = PostLoginRequest(name: "hoge", password: "fuga")
        XCTAssertEqual(request.endpoint, "/login")
        XCTAssertEqual(request.requestBodies?["name"] as! String, "hoge")
        XCTAssertEqual(request.requestBodies?["password"] as! String, "fuga")
        XCTAssertEqual(request.httpMethod, "post")
    }
}
