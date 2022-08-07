//
//  AuthorizationUseCaseProtocol.swift
//  
//
//  Created by Dmytro Vorko on 07.08.2022.
//

import Foundation

public protocol AuthorizationUseCaseProtocol {
    func login(username: String, password: String) async throws 
}
