//
//  SettingStorageFactory.swift
//  
//
//  Created by Dmytro Vorko on 07.08.2022.
//

import Foundation

public protocol SettingStorageFactoryProtocol {
    var authorization: AuthorizationSettingsStorageProtocol { get }
    var user: UserSettingsStorageProtocol { get }
}

public class SettingStorageFactory {
    public init() {}
}

extension SettingStorageFactory: SettingStorageFactoryProtocol {
    public var authorization: AuthorizationSettingsStorageProtocol {
        AuthorizationSettingsStorage(
            regularStorage: UserDefaults.regular ?? .standard, // Should be used keychain storage
            safeStorage: UserDefaults.safe ?? .standard
        )
    }
    
    public var user: UserSettingsStorageProtocol {
        UserSettingsStorage(UserDefaults.regular ?? .standard)
    }
}
