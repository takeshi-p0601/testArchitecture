//
//  MockPostLoginAPICommander.swift
//  testArchitectureTests
//
//  Created by Takeshi Komori on 2023/10/28.
//

@testable import testArchitecture

struct MockPostLoginAPICommander: PostLoginAPICommandable {
    let client: APIClientable
    private var _dummyResult: PostLoginAPIResponse = .init(success: true)
    
    init(client: APIClientable = APIClient(), dummyResult: PostLoginAPIResponse) {
        self.client = client
        self._dummyResult = dummyResult
    }
    
    func command(name: String, password: String) async -> PostLoginAPIResponse {
        return _dummyResult
    }
}
