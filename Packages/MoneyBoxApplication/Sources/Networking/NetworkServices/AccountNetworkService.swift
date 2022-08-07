//
//  AccountNetworkService.swift
//  
//
//  Created by Dmytro Vorko on 06.08.2022.
//

import Foundation
import Core

public protocol AccountNetworkServiceProtocol: AnyObject {
    var tokenProvider: TokenProviderType? { get set }
    
    func account() async throws -> AccountResponseDTO
}

final class AccountNetworkService {
    private typealias AccountTarget = Target<AccountRouter>
    
    weak var tokenProvider: TokenProviderType?
    private let networking: Networking
    private let configurations: NetworkConfigurationsType
    
    init(
        _ networking: Networking,
        configurations: NetworkConfigurationsType
    ) {
        self.networking = networking
        self.configurations = configurations
    }
}

// MARK: - AccountNetworkServiceProtocol

extension AccountNetworkService: AccountNetworkServiceProtocol {
    func account() async throws -> AccountResponseDTO {
        let provider = RequestDataProvider(configurations, token: self.tokenProvider?.authorizationToken())
        let target = AccountTarget(provider, router: .products)
        return try await networking.perform(target: target)
    }
}
