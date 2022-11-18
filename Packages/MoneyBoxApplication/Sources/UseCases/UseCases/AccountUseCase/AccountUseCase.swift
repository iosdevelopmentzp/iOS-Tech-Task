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
    private let authorizationTokenProvider: AuthorizationTokenProviderProtocol
    
    init(
        networking: AccountNetworkServiceProtocol,
        authorizationTokenProvider: AuthorizationTokenProviderProtocol
    ) {
        self.networking = networking
        self.authorizationTokenProvider = authorizationTokenProvider
        self.networking.tokenProvider = self
    }
}

// MARK: - AccountUseCaseProtocol

extension AccountUseCase: AccountUseCaseProtocol {
    enum Error: Swift.Error {
        case userNotHaveAccountById
    }
    
    func userAccount() async throws -> UserAccount {
        let accountResponse = try await networking.account()
        return UserAccount.Factory.make(accountResponse)
    }
    
    func productDetails(by id: Int) async throws -> Product {
        let userAccount = try await userAccount()
        
        guard let individualAccount = userAccount.products?.first(where: {
            $0.id == id
        }) else {
            throw Error.userNotHaveAccountById
        }
        return individualAccount
    }
}

// MARK: - TokenProviderType

extension AccountUseCase: TokenProviderType {
    func authorizationToken() -> String? {
        authorizationTokenProvider.authorizationToken
    }
}
