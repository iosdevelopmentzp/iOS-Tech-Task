//
//  TargetType.swift
//  
//
//  Created by Dmytro Vorko on 06.08.2022.
//

import Foundation
import Alamofire

// The protocol used to define the specifications necessary for a networking.
public protocol TargetType: URLConvertible {
    var scheme: String { get }

    /// The target's base host
    var host: String { get }

    /// The path to be appended to `baseURL` to form the full `URL`.
    var path: String { get }

    /// The HTTP method used in the request.
    var method: Alamofire.HTTPMethod { get }

    /// The headers to be used in the request.
    var headers: [String: String]? { get }
    
    var parameters: [String: Any]? { get }
}

extension TargetType {
    var scheme: String { "https" }
}
