//
//  OneOffPaymentRequestDTO.swift
//  
//
//  Created by Dmytro Vorko on 05.08.2022.
//

import Foundation

public struct OneOffPaymentRequestDTO: Encodable, Equatable {
    // MARK: - Nested
    
    enum CodingKeys: String, CodingKey {
        case amount = "Amount"
        case investorProductID = "InvestorProductId"
    }
    
    // MARK: - Properties
    
    public let amount: Int
    public let investorProductID: AdoptableID
    
    // MARK: - Constructor
    
    public init(amount: Int, investorProductID: AdoptableID) {
        self.amount = amount
        self.investorProductID = investorProductID
    }
}
