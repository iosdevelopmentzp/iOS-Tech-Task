//
//  AuthorizationSettingsStorageProtocol.swift
//  
//
//  Created by Dmytro Vorko on 07.08.2022.
//

import Foundation

public protocol AuthorizationTokenProviderProtocol {
    var authorizationToken: String? { get }
}

public protocol AuthorizationSettingsStorageProtocol: AuthorizationTokenProviderProtocol {
    func saveAuthorizationToken(_ token: String)
    func clearAuthorizationToken()
}
