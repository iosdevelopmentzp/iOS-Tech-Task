//
//  AuthorizationUseCaseProtocol.swift
//  
//
//  Created by Dmytro Vorko on 07.08.2022.
//

import Foundation

public protocol AuthorizationUseCaseProtocol {
    var isAuthorized: Bool { get }
    
    func clearAuthorizationToken()
    func login(username: String, password: String) async throws 
}
