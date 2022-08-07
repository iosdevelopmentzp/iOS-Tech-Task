//
//  AuthorizationSettingsStorageProtocol.swift
//  
//
//  Created by Dmytro Vorko on 07.08.2022.
//

import Foundation

public protocol AuthorizationSettingsStorageProtocol {
    var authorizationToken: String? { get }

    func saveAuthorizationToken(_ token: String)
    func clearAuthorizationToken()
}
