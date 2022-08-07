//
//  SettingsStorageAssembly.swift
//  
//
//  Created by Dmytro Vorko on 07.08.2022.
//

import Foundation
import Swinject
import SettingsStorage

struct SettingsStorageAssembly: Assembly {
    func assemble(container: Container) {
        // SettingStorageFactoryProtocol
        
        container.register(SettingStorageFactoryProtocol.self) { _ in
            SettingStorageFactory()
        }.inObjectScope(.container)
        
        // AuthorizationSettingsStorageProtocol
        
        container.register(AuthorizationSettingsStorageProtocol.self) { r in
            r.resolveOrFail(SettingStorageFactoryProtocol.self).authorization
        }
        
        // UserSettingsStorageProtocol
        
        container.register(UserSettingsStorageProtocol.self) { r in
            r.resolveOrFail(SettingStorageFactoryProtocol.self).user
        }
    }
}
