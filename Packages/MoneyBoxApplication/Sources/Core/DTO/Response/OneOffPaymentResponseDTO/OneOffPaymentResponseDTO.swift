//
//  OneOffPaymentResponseDTO.swift
//  
//
//  Created by Dmytro Vorko on 05.08.2022.
//

import Foundation

public struct OneOffPaymentResponseDTO: Decodable, Equatable {
    // MARK: - Nested
    
    enum CodingKeys: String, CodingKey {
        case moneybox = "Moneybox"
    }
    
    // MARK: - Propeties
    
    public let moneybox: Double
}
