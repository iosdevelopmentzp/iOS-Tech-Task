//
//  NetworkingProtocol.swift
//  
//
//  Created by Dmytro Vorko on 21/10/2022.
//

import Foundation

protocol NetworkingProtocol {
    func dataRequest<R: Decodable>(target: TargetType, decoder: JSONDecoder) async throws -> R
}

// MARK: - Extension

extension NetworkingProtocol {
    func dataRequest<R: Decodable>(target: TargetType) async throws -> R {
        try await dataRequest(target: target, decoder: .init())
    }
}
