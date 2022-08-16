//
//  AuthorizationUseCase.swift
//  
//
//  Created by Dmytro Vorko on 07.08.2022.
//

import Foundation
import Core
import Networking
import SettingsStorage
import AppNotifier

final class AuthorizationUseCase {
    private let networking: AuthorizationNetworkServiceProtocol
    
    private let authorizationSettingsStorage: AuthorizationSettingsStorageProtocol
    private let userSettingsStorage: UserSettingsStorageProtocol
    private let authorizationNotifier: AuthorizationNotifierProtocol
    
    init(
        networking:  AuthorizationNetworkServiceProtocol,
        authorizationSettings: AuthorizationSettingsStorageProtocol,
        userSettings: UserSettingsStorageProtocol,
        authorizationNotifier: AuthorizationNotifierProtocol
    ) {
        self.networking = networking
        self.authorizationSettingsStorage = authorizationSettings
        self.userSettingsStorage = userSettings
        self.authorizationNotifier = authorizationNotifier
        
        #warning("For Testing")
        #if DEBUG
        self.clearAuthorizationToken()
        #endif
    }
}

// MARK: - AuthorizationUseCaseProtocol

extension AuthorizationUseCase: AuthorizationUseCaseProtocol {
    var isAuthorized: Bool {
        authorizationSettingsStorage.authorizationToken != nil
    }
    
    func login(username: String, password: String) async throws {
        let response = try await networking.login(.init(email: username, password: password, idfa: "ANYTHING"))
        authorizationSettingsStorage.saveAuthorizationToken(response.session.bearerToken)
        userSettingsStorage.saveUserName(
            firstName: response.user.firstName,
            lastName: response.user.lastName
        )
        authorizationNotifier.notify(event: .didLogin)
    }
    
    func clearAuthorizationToken() {
        authorizationSettingsStorage.clearAuthorizationToken()
    }
}
