//
//  AccountUseCase.swift
//  
//
//  Created by Dmytro Vorko on 07.08.2022.
//

import Foundation
import Core
import Networking
import SettingsStorage

final class AccountUseCase {
    private let networking: AccountNetworkServiceProtocol
    private let authorizationSettingsStorage: AuthorizationSettingsStorageProtocol
    
    init(
        networking: AccountNetworkServiceProtocol,
        authorizationSettingsStorage: AuthorizationSettingsStorageProtocol
    ) {
        self.networking = networking
        self.authorizationSettingsStorage = authorizationSettingsStorage
        self.networking.tokenProvider = self
    }
}

// MARK: - AccountUseCaseProtocol

extension AccountUseCase: AccountUseCaseProtocol {
    func products() async throws -> [Int] {
        let account = try await networking.account()
        return account.productResponses?.map(\.id) ?? []
    }
}

// MARK: - TokenProviderType

extension AccountUseCase: TokenProviderType {
    func authorizationToken() -> String? {
        authorizationSettingsStorage.authorizationToken
    }
}
