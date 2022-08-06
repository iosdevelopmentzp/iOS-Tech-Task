//
//  ErrorResponseDTO.swift
//  
//
//  Created by Dmytro Vorko on 05.08.2022.
//

import Foundation

public struct ErrorResponseDTO: Decodable, Equatable {
    // MARK: - Nested
    
    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case message = "Message"
        case validationErrors = "ValidationErrors"
    }
    
    public struct ValidationError: Decodable, Equatable {
        enum CodingKeys: String, CodingKey {
            case name = "Name"
            case message = "Message"
        }
        
        public let name: String?
        public let message: String?
    }
    
    // MARK: - Properties
    
    public let name: String
    public let message: String
    public let validationErrors: [ValidationError]?
}
