//
//  NetworkingAssembly.swift
//  
//
//  Created by Dmytro Vorko on 02.08.2022.
//

import Swinject
import Networking

struct NetworkingAssembly: Assembly {
    func assemble(container: Container) {
        // NetworkingFactoryProtocol
        
        container.register(NetworkingFactoryProtocol.self) { resolver in
            NetworkingFactory()
        }.inObjectScope(.container)
        
        // AuthorizationNetworkServiceProtocol
        
        container.register(AuthorizationNetworkServiceProtocol.self) { r in
            r.resolveOrFail(NetworkingFactoryProtocol.self).authorization(
                configurations: r.resolveOrFail()
            )
        }
        
        // AccountNetworkServiceProtocol
        
        container.register(AccountNetworkServiceProtocol.self) { r in
            r.resolveOrFail(NetworkingFactoryProtocol.self).account(configurations: r.resolveOrFail())
        }
    }
}
