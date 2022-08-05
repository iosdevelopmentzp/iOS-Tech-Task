//
//  LoginRequestDTO.swift
//  
//
//  Created by Dmytro Vorko on 05.08.2022.
//

import Foundation

public struct LoginRequestDTO: Encodable, Equatable {
    // MARK: - Nested
    
    enum CodingKeys: String, CodingKey {
        case email = "Email"
        case password = "Password"
        case idfa = "Idfa"
    }
    
    // MARK: - Properties
    
    let email: String
    let password: String
    let idfa: String
    
    // MARK: - Constructor
    
    public init(email: String, password: String, idfa: String) {
        self.email = email
        self.password = password
        self.idfa = idfa
    }
}
