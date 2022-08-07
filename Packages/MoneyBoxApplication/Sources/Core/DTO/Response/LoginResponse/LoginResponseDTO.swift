//
//  LoginResponseDTO.swift
//  
//
//  Created by Dmytro Vorko on 05.08.2022.
//

import Foundation

public struct LoginResponseDTO: Decodable, Equatable {
    // MARK: - Nested
    
    enum CodingKeys: String, CodingKey {
        case session = "Session"
        case user = "User"
    }
    
    public struct Session: Decodable, Equatable {
        enum CodingKeys: String, CodingKey {
            case bearerToken = "BearerToken"
        }
        
        public let bearerToken: String
    }
    
    public struct User: Decodable, Equatable {
        enum CodingKeys: String, CodingKey {
            case firstName = "FirstName"
            case lastName = "LastName"
        }
        
        public let firstName: String?
        public let lastName: String?
    }
    
    // MARK: - Properties
    
    public let session: Session
    public let user: User
}
