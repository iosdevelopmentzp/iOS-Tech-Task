//
//  AuthorizationNetworkService.swift
//  
//
//  Created by Dmytro Vorko on 06.08.2022.
//

import Foundation
import Core

public protocol AuthorizationNetworkServiceProtocol {
    func login(_ data: LoginRequestDTO) async throws -> LoginResponseDTO
}

final class AuthorizationNetworkService {
    private typealias AuthorizationTarget = Target<AuthorizationRouter>
    
    private let networking: Networking
    private let configurations: NetworkConfigurationsType
    
    init(_ networking: Networking, configurations: NetworkConfigurationsType) {
        self.networking = networking
        self.configurations = configurations
    }
}

// MARK: - AuthorizationNetworkServiceProtocol

extension AuthorizationNetworkService: AuthorizationNetworkServiceProtocol {
    func login(_ data: LoginRequestDTO) async throws -> LoginResponseDTO {
        let dataProvider = RequestDataProvider(configurations, parameters: try data.toDictionary())
        let target = AuthorizationTarget(dataProvider, router: .login)
        let response: MultipleDecodableModel<ErrorResponseDTO, LoginResponseDTO> = try await networking.perform(target: target)
        return try response.mainExpectation()
    }
}