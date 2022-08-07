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
        authorizationSettingsStorage: AuthorizationSettingsStorageProtocol
    ) -> AccountUseCaseProtocol
    
    func authorisation(
        networking: AuthorizationNetworkServiceProtocol,
        authorizationSettings: AuthorizationSettingsStorageProtocol,
        userSettings: UserSettingsStorageProtocol,
        authorizationNotifier: AuthorizationNotifierProtocol
    ) -> AuthorizationUseCaseProtocol
}

public final class UseCasesFactory {
    public init() {}
}

// MARK: - UseCasesFactoryProtocol

extension UseCasesFactory: UseCasesFactoryProtocol {
    public func account(
        networking: AccountNetworkServiceProtocol,
        authorizationSettingsStorage: AuthorizationSettingsStorageProtocol
    ) -> AccountUseCaseProtocol {
        AccountUseCase(networking: networking, authorizationSettingsStorage: authorizationSettingsStorage)
    }
    
    public func authorisation(
        networking: AuthorizationNetworkServiceProtocol,
        authorizationSettings: AuthorizationSettingsStorageProtocol,
        userSettings: UserSettingsStorageProtocol,
        authorizationNotifier: AuthorizationNotifierProtocol
    ) -> AuthorizationUseCaseProtocol {
        AuthorizationUseCase(
            networking: networking,
            authorizationSettings: authorizationSettings,
            userSettings: userSettings,
            authorizationNotifier: authorizationNotifier
        )
    }
}
