//
//  PostLoginAPICommander.swift
//  testArchitecture
//
//  Created by Takeshi Komori on 2023/10/28.
//

protocol PostLoginAPICommandable {
    var client: APIClientable { get }
    func command(name: String, password: String) async -> PostLoginAPIResponse
}

struct PostLoginRequest: APIRequestProtocol {
    typealias Response = PostLoginAPIResponse
    
    var httpMethod: String { "post" }
    var endpoint: String { "/login" }
    var requestBodies: [String : Any]?
    var queryStrings: [String : String]?
    var httpHeaderFields: [String : String]?
}

struct PostLoginAPICommander: PostLoginAPICommandable {
    let client: APIClientable
    
    init(client: APIClientable) {
        self.client = client
    }
    
    func command(name: String, password: String) async -> PostLoginAPIResponse {
        do {
            let request = PostLoginRequest(requestBodies: [
                "name" : name,
                "password" : password
            ])
            let result = try await self.client.command(request)
            return result
        } catch {
            return PostLoginAPIResponse(success: false)
        }
    }
}
