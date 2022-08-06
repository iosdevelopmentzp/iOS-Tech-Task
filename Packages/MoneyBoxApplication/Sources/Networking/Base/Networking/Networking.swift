//
//  Networking.swift
//  
//
//  Created by Dmytro Vorko on 06.08.2022.
//

import Foundation
import Alamofire

final class Networking {
    func perform<R: Decodable>(target: TargetType, decoder: JSONDecoder = JSONDecoder()) async throws -> R {
        let task = AF.request(
            target,
            method: target.method,
            parameters: target.parameters,
            headers: target.headers?.asHTTPHeaders
        )
            .validate(statusCode: 200 ... 399)
            .validate(contentType: ["application/json"])
            .serializingDecodable(R.self, decoder: decoder)

        return try await task.value
    }
}
