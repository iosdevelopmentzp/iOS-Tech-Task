//
//  URLSession+Async.swift
//  
//
//  Created by Dmytro Vorko on 20/10/2022.
//

import Foundation

extension URLSession {
    @available(iOS, deprecated: 15.0, message: "This extension is no longer necessary. Use API built into SDK")
    func data(for urlRequest: URLRequest) async throws -> (Data, URLResponse) {
        try await withCheckedThrowingContinuation { continuation in
            let task = self.dataTask(with: urlRequest) { data, response, error in
                guard let data = data, let response = response else {
                    let error = error ?? URLError(.badServerResponse)
                    return continuation.resume(throwing: error)
                }
                
                continuation.resume(returning: (data, response))
            }
            task.resume()
        }
    }
}
