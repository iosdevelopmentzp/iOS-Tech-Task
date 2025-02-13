//
//  UseCasesAssembly.swift
//  
//
//  Created by Dmytro Vorko on 02.08.2022.
//

import UseCases
import Swinject
import Networking
import AppNotifier
import SettingsStorage

struct UseCasesAssembly: Assembly {
    func assemble(container: Container) {
        // UseCasesFactoryProtocol
        
        container.register(UseCasesFactoryProtocol.self) { _ in
            UseCasesFactory()
        }.inObjectScope(.container)
        
        // AuthorizationUseCaseProtocol
        
        container.register(AuthorizationUseCaseProtocol.self) { r in
            r.resolveOrFail(UseCasesFactoryProtocol.self).authorisation(
                networking: r.resolveOrFail(),
                authorizationSettings: r.resolveOrFail(),
                userSettings: r.resolveOrFail()
            )
        }
        
        // AccountUseCaseProtocol
        
        container.register(AccountUseCaseProtocol.self) { r in
            r.resolveOrFail(UseCasesFactoryProtocol.self).account(
                networking: r.resolveOrFail(),
                authorizationTokenProvider: r.resolveOrFail()
            )
        }
        
        // TransactionsUseCaseProtocol
        
        container.register(TransactionsUseCaseProtocol.self) { r in
            r.resolveOrFail(UseCasesFactoryProtocol.self).transactions(
                networking: r.resolveOrFail(),
                authorizationTokenProvider: r.resolveOrFail()
            )
        }
    }
}
