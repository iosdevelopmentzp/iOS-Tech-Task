//
//  APIConfigurationAssembly.swift
//  
//
//  Created by Dmytro Vorko on 02.08.2022.
//

import Swinject
import Networking

struct APIConfigurationAssembly: Assembly {
    private let provider: () -> (NetworkConfigurationsType)
    
    init(_ provider: @escaping () -> (NetworkConfigurationsType)) {
        self.provider = provider
    }
    
    func assemble(container: Container) {
        container.register(NetworkConfigurationsType.self) { _ in
            provider()
        }.inObjectScope(.container)
    }
}

