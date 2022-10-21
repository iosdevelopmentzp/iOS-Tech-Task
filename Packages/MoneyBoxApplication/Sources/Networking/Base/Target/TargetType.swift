//
//  TargetType.swift
//  
//
//  Created by Dmytro Vorko on 06.08.2022.
//

import Foundation

public enum HTTPMethod: String {
    case connect = "CONNECT"
    case delete = "DELETE"
    case get = "GET"
    case head = "HEAD"
    case options = "OPTIONS"
    case patch = "PATCH"
    case post = "POST"
    case put = "PUT"
    case query = "QUERY"
    case trace = "TRACE"
}

public protocol TargetType {
    /// URL scheme
    var scheme: String { get }

    /// The target's base host
    var host: String { get }

    /// The path to be appended to `baseURL` to form the full `URL`.
    var path: String { get }

    /// The HTTP method used in the request.
    var method: HTTPMethod { get }

    /// The headers to be used in the request.
    var headers: [String: String]? { get }
    
    ///  Request body
    var parameters: [String: Any]? { get }
}

// MARK: - TargetType Extension

extension TargetType {
    var scheme: String { "https" }
    
    func asURL() throws -> URL {
        var components = URLComponents()
        components.host = self.host
        components.path = self.path
        components.scheme = self.scheme
        
        guard let url = components.url else {
            throw URLError(.badURL)
        }
        return url
    }
    
    func asURLRequest() throws -> URLRequest {
        var urlRequest = URLRequest(url: try self.asURL())
        urlRequest.httpMethod = self.method.rawValue
        
        self.headers?.forEach {
            urlRequest.addValue($0.value, forHTTPHeaderField: $0.key)
        }
        
        if let parameters = self.parameters, !parameters.isEmpty {
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters)
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        }
        
        return urlRequest
    }
}
