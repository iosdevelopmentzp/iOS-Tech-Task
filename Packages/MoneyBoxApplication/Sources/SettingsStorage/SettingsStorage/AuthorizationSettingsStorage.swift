//
//  SettingsStorage.swift
//  
//
//  Created by Dmytro Vorko on 07.08.2022.
//

import Foundation

final class AuthorizationSettingsStorage {
    private let regularStorage: KeyStorageProtocol
    private let safeStorage: KeyStorageProtocol
    
    init(regularStorage: KeyStorageProtocol, safeStorage: KeyStorageProtocol) {
        self.regularStorage = regularStorage
        self.safeStorage = safeStorage
    }
}

// MARK: - SettingsStorageProtocol

extension AuthorizationSettingsStorage: AuthorizationSettingsStorageProtocol {
    var authorizationToken: String? {
        safeStorage.get(key: SafeCachingKeys.authorizationToken)
    }
    
    func saveAuthorizationToken(_ token: String) {
        safeStorage.set(key: SafeCachingKeys.authorizationToken, value: token)
    }
    
    func clearAuthorizationToken() {
        safeStorage.remove(key: SafeCachingKeys.authorizationToken)
    }
}
