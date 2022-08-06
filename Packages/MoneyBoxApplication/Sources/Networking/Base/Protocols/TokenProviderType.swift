//
//  TokenProviderType.swift
//  
//
//  Created by Dmytro Vorko on 06.08.2022.
//

import Foundation

/// Entity that should be passed outside to get a token
public protocol TokenProviderType {
    func authorizationToken() -> String?
}
