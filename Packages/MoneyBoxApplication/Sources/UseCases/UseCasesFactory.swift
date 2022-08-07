//
//  UseCasesFactory.swift
//  
//
//  Created by Dmytro Vorko on 07.08.2022.
//

import Foundation
import Networking

public protocol UseCasesFactoryProtocol {
    func account(_ networking: AccountNetworkServiceProtocol) -> AccountUseCaseProtocol
    func authorization(_ networking: AuthorizationNetworkServiceProtocol) -> AuthorizationUseCaseProtocol
}

public final class UseCasesFactory {
    public init() {}
}

// MARK: - UseCasesFactoryProtocol

extension UseCasesFactory: UseCasesFactoryProtocol {
    public func account(_ networking: AccountNetworkServiceProtocol) -> AccountUseCaseProtocol {
        AccountUseCase(networking)
    }
    
    public func authorization(_ networking: AuthorizationNetworkServiceProtocol) -> AuthorizationUseCaseProtocol {
        AuthorizationUseCase(networking: networking)
    }
}
