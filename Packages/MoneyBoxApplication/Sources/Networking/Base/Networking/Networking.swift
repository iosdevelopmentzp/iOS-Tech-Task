//
//  Networking.swift
//  
//
//  Created by Dmytro Vorko on 06.08.2022.
//

import Foundation
import Alamofire
import AlamofireNetworkActivityLogger

/// Base Util to perform requests
final class Networking {
    private struct Constants {
        static let validStatusCode = 200 ... 399
    }
    
    init() {
        // TODO: - Move to more suitable place.
        NetworkActivityLogger.shared.startLogging()
        NetworkActivityLogger.shared.level = .debug
    }
    
    func perform<R: Decodable>(target: TargetType, decoder: JSONDecoder = JSONDecoder()) async throws -> R {
        let task = AF.request(
            target,
            method: target.method,
            parameters: target.parameters,
            headers: target.headers?.asHTTPHeaders
        )
            .validate(validStatusCode: Array(200 ... 399), expectedType: R.self, decoder: decoder)
            .validate(contentType: ["application/json"])
            .serializingDecodable(R.self, automaticallyCancelling: true, decoder: decoder)

        return try await task.value
    }
}
