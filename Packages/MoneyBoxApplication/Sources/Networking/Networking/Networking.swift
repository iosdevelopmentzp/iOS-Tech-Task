//
//  Networking.swift
//  
//
//  Created by Dmytro Vorko on 06.08.2022.
//

import Foundation

/// Base Util to perform requests
final class Networking {
    // MARK: - Properties
    
    private let session: URLSession
    
    // MARK: - Constructor
    
    init(_ session: URLSession = .shared) {
        self.session = session
    }
}

// MARK: - NetworkingProtocol

extension Networking: NetworkingProtocol {
    func dataRequest<R: Decodable>(target: TargetType, decoder: JSONDecoder) async throws -> R {
        let (data, _) = try await session.data(for: try target.asURLRequest())
        return try decoder.decode(R.self, from: data)
    }
}
