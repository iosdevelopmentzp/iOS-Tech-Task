//
//  AuthorizationUseCase.swift
//  
//
//  Created by Dmytro Vorko on 07.08.2022.
//

import Foundation
import Core
import Networking

final class AuthorizationUseCase {
    private let networking: AuthorizationNetworkServiceProtocol
    
    init(networking:  AuthorizationNetworkServiceProtocol) {
        self.networking = networking
    }
}

// MARK: - AuthorizationUseCaseProtocol

extension AuthorizationUseCase: AuthorizationUseCaseProtocol {
    func login(username: String, password: String) async throws {
        let response = try await networking.login(.init(email: username, password: password, idfa: "ANYTHING"))
        debugPrint("Did login with token: \(response.session.bearerToken)")
        debugPrint("User: \(response.user.firstName ?? "") \(response.user.lastName ?? "")")
        // TODO: - Store token to keychain
        // TODO: - Store user to data base
    }
}
