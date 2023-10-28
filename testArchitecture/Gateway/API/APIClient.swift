//
//  APIClient.swift
//  testArchitecture
//
//  Created by Takeshi Komori on 2023/10/28.
//

import Foundation

protocol APIRequestProtocol {
    associatedtype Response: Codable
    var httpMethod: String { get }
    var endpoint: String { get }
    var requestBodies: [String : Any]? { get }
    var queryStrings: [String : String]? { get }
    var httpHeaderFields: [String : String]? { get }
}

protocol APIClientable {
    var baseUrlStr: String { get }
    func command<Request: APIRequestProtocol>(_ request: Request) async throws -> Request.Response
}

enum APIClientError: Error {
    case normal
}

class APIClient: APIClientable {
    var baseUrlStr: String { "http://localhost" }
    
    func command<Request: APIRequestProtocol>(_ request: Request) async throws -> Request.Response {
        var urlComponents = URLComponents(string: baseUrlStr)!
        if let queryStrings = request.queryStrings {
            urlComponents.queryItems = queryStrings.map {
                URLQueryItem(name: $0.key, value: $0.value)
            }
        }
        var urlRequest = URLRequest(url: urlComponents.url!)
        urlRequest.httpMethod = request.httpMethod
        urlRequest.allHTTPHeaderFields = request.httpHeaderFields
        
        do {
            let data = try await URLSession.shared.data(for: urlRequest)
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let result = try decoder.decode(Request.Response.self, from: data.0)
            return result
        } catch {
            throw APIClientError.normal
        }
    }
}
