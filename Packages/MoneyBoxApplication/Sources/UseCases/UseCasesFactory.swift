//
//  UseCasesFactory.swift
//  
//
//  Created by Dmytro Vorko on 07.08.2022.
//

import Foundation
import Networking
import SettingsStorage

public protocol UseCasesFactoryProtocol {
    func account(_ networking: AccountNetworkServiceProtocol) -> AccountUseCaseProtocol
    
    func authorisation(
        networking: AuthorizationNetworkServiceProtocol,
        authorizationSettings: AuthorizationSettingsStorageProtocol,
        userSettings: UserSettingsStorageProtocol
    ) -> AuthorizationUseCaseProtocol
}

public final class UseCasesFactory {
    public init() {}
}

// MARK: - UseCasesFactoryProtocol

extension UseCasesFactory: UseCasesFactoryProtocol {
    public func account(_ networking: AccountNetworkServiceProtocol) -> AccountUseCaseProtocol {
        AccountUseCase(networking)
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
