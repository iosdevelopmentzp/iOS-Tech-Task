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
    public let investorProductID: Int
    
    // MARK: - Constructor
    
    public init(amount: Int, investorProductID: Int) {
        self.amount = amount
        self.investorProductID = investorProductID
    }
}
