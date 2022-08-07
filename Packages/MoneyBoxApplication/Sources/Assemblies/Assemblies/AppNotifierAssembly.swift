//
//  AppNotifierAssembly.swift
//  
//
//  Created by Dmytro Vorko on 07.08.2022.
//

import Foundation
import Swinject
import AppNotifier

struct AppNotifierAssembly: Assembly {
    func assemble(container: Container) {
        // SettingStorageFactoryProtocol
        
        container.register(AppNotifierFactoryProtocol.self) { _ in
            AppNotifierFactory()
        }.inObjectScope(.container)
        
        // AuthorizationSettingsStorageProtocol
        
        container.register(AuthorizationNotifierProtocol.self) { r in
            r.resolveOrFail(AppNotifierFactoryProtocol.self).authorizationNotifier
        }
    }
}

