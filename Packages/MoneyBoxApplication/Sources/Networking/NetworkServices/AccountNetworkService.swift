//
//  AccountNetworkService.swift
//  
//
//  Created by Dmytro Vorko on 06.08.2022.
//

import Foundation
import Core

public protocol AccountNetworkServiceProtocol {
    func products() async throws -> AccountResponseDTO
}

final class AccountNetworkService {
    private typealias AccountTarget = Target<AccountRouter>
    
    private let networking: Networking
    private let configurations: NetworkConfigurationsType
    private let tokenProvider: TokenProviderType?
    
    init(
        _ networking: Networking,
        configurations: NetworkConfigurationsType,
        tokenProvider: TokenProviderType?
    ) {
        self.networking = networking
        self.configurations = configurations
        self.tokenProvider = tokenProvider
    }
}

// MARK: - AccountNetworkServiceProtocol

extension AccountNetworkService: AccountNetworkServiceProtocol {
    func products() async throws -> AccountResponseDTO {
        let provider = RequestDataProvider(configurations, token: self.tokenProvider?.authorizationToken())
        let target = AccountTarget(provider, router: .products)
        return try await networking.perform(target: target)
    }
}
