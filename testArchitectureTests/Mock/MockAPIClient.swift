//
//  MockAPIClient.swift
//  testArchitectureTests
//
//  Created by Takeshi Komori on 2023/10/28.
//

@testable import testArchitecture

class MockAPIClient<T: APIRequestProtocol>: APIClientable {
    var baseUrlStr: String = ""
    private var _dummyResult: T.Response
    
    init(dummyResult: T.Response) {
        self._dummyResult = dummyResult
    }
    
    func command<Request: APIRequestProtocol>(_ request: Request) async throws -> Request.Response {
        return self._dummyResult as! Request.Response
    }
}
