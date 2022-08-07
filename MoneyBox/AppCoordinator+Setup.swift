//
//  AppCoordinator+Setup.swift
//  MoneyBox
//
//  Created by Dmytro Vorko on 07.08.2022.
//

import Foundation
import Coordinator
import DependencyResolver
import Assemblies
import UIKit

extension AppCoordinator {
    static func setup(with window: UIWindow) -> AppCoordinator {
        return AppCoordinator(window: window, resolver: setupDependencyResolver())
    }
}

private extension AppCoordinator {
    static func setupDependencyResolver() -> DependencyResolver {
        let resolver = DependencyResolver()
        
        let assemblyFactory = AssembliesFactory()
        
        resolver.append(assemblies: [
            assemblyFactory.useCases,
            assemblyFactory.networking,
            assemblyFactory.notifier,
            assemblyFactory.settingsStorage,
            assemblyFactory.apiConfiguration(APIConfiguration.decoded())
        ])
        return resolver
    }
}
