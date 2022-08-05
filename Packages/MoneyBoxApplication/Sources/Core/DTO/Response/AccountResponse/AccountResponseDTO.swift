//
//  AccountResponseDTO.swift
//  
//
//  Created by Dmytro Vorko on 05.08.2022.
//

import Foundation

public struct AccountResponseDTO: Decodable, Equatable {
    // MARK: - Nested
    
    enum CodingKeys: String, CodingKey {
        case moneyboxEndOfTaxYear = "MoneyboxEndOfTaxYear"
        case totalPlanValue = "TotalPlanValue"
        case totalEarnings = "TotalEarnings"
        case totalContributionsNet = "TotalContributionsNet"
        case totalEarningsAsPercentage = "TotalEarningsAsPercentage"
        case productResponses = "ProductResponses"
        case accounts = "Accounts"
    }
    
    // MARK: - Properties
    
    public let moneyboxEndOfTaxYear: String?
    public let totalPlanValue: Double?
    public let totalEarnings: Double?
    public let totalContributionsNet: Double?
    public let totalEarningsAsPercentage: Double?
    public let productResponses: [ProductResponseDTO]?
    public let accounts: [AccountDTO]?
}
