//
//  UserSettingsStorage.swift
//  
//
//  Created by Dmytro Vorko on 07.08.2022.
//

import Foundation

final class UserSettingsStorage {
    private let regularStorage: KeyStorageProtocol
    
    
    init(_ regularStorage: KeyStorageProtocol) {
        self.regularStorage = regularStorage
    }
}

extension UserSettingsStorage: UserSettingsStorageProtocol {
    var userName: (firstName: String?, lastName: String?)? {
        let firstName: String? = regularStorage.get(key: RegularCachingKeys.userFirstName)
        let lastName: String? = regularStorage.get(key: RegularCachingKeys.userLastName)
        guard !(firstName ?? "").isEmpty || !(lastName ?? "").isEmpty else { return nil }
        return (firstName, lastName)
    }
    
    func saveUserName(firstName: String?, lastName: String?) {
        regularStorage.set(key: RegularCachingKeys.userFirstName, value: firstName)
        regularStorage.set(key: RegularCachingKeys.userLastName, value: lastName)
    }
    
    func clearUserName() {
        regularStorage.remove(key: RegularCachingKeys.userFirstName)
        regularStorage.remove(key: RegularCachingKeys.userLastName)
    }
}
