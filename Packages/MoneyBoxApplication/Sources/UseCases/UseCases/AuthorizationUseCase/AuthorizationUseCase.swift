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

final class AuthorizationUseCase {
    private let networking: AuthorizationNetworkServiceProtocol
    
    private let authorizationSettingsStorage: AuthorizationSettingsStorageProtocol
    private let userSettingsStorage: UserSettingsStorageProtocol
    
    init(
        networking:  AuthorizationNetworkServiceProtocol,
        authorizationSettings: AuthorizationSettingsStorageProtocol,
        userSettings: UserSettingsStorageProtocol
    ) {
        self.networking = networking
        self.authorizationSettingsStorage = authorizationSettings
        self.userSettingsStorage = userSettings
    }
}

// MARK: - AuthorizationUseCaseProtocol

extension AuthorizationUseCase: AuthorizationUseCaseProtocol {
    func login(username: String, password: String) async throws {
        let response = try await networking.login(.init(email: username, password: password, idfa: "ANYTHING"))
        debugPrint("Did login with token: \(response.session.bearerToken)")
        authorizationSettingsStorage.saveAuthorizationToken(response.session.bearerToken)
        userSettingsStorage.saveUserName(
            firstName: response.user.firstName,
            lastName: response.user.lastName
        )
    }
}
