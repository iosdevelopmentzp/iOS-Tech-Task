//
//  UseCasesFactory.swift
//  
//
//  Created by Dmytro Vorko on 07.08.2022.
//

import Foundation
import Networking
import SettingsStorage
import AppNotifier

public protocol UseCasesFactoryProtocol {
    func account(
        networking: AccountNetworkServiceProtocol,
        authorizationTokenProvider: AuthorizationTokenProviderProtocol
    ) -> AccountUseCaseProtocol
    
    func authorisation(
        networking: AuthorizationNetworkServiceProtocol,
        authorizationSettings: AuthorizationSettingsStorageProtocol,
        userSettings: UserSettingsStorageProtocol
    ) -> AuthorizationUseCaseProtocol
    
    func transactions(
        networking: TransactionsNetworkServiceProtocol,
        authorizationTokenProvider: AuthorizationTokenProviderProtocol
    ) -> TransactionsUseCaseProtocol
}

public final class UseCasesFactory {
    public init() {}
}

// MARK: - UseCasesFactoryProtocol

extension UseCasesFactory: UseCasesFactoryProtocol {
    public func transactions(
        networking: TransactionsNetworkServiceProtocol,
        authorizationTokenProvider: AuthorizationTokenProviderProtocol
    ) -> TransactionsUseCaseProtocol {
        TransactionsUseCase(networking: networking, authorizationTokenProvider: authorizationTokenProvider)
    }
    
    public func account(
        networking: AccountNetworkServiceProtocol,
        authorizationTokenProvider: AuthorizationTokenProviderProtocol
    ) -> AccountUseCaseProtocol {
        AccountUseCase(networking: networking, authorizationTokenProvider: authorizationTokenProvider)
    }
    
    public func authorisation(
        networking: AuthorizationNetworkServiceProtocol,
        authorizationSettings: AuthorizationSettingsStorageProtocol,
        userSettings: UserSettingsStorageProtocol
    ) -> AuthorizationUseCaseProtocol {
        AuthorizationUseCase(
            networking: networking,
            authorizationSettings: authorizationSettings,
            userSettings: userSettings
        )
    }
}
