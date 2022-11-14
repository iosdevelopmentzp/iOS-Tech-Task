//
//  ProductDTO.swift
//  
//
//  Created by Dmytro Vorko on 05.08.2022.
//

import Foundation

public struct ProductDTO: Decodable, Equatable {
    // MARK: - Nested
    
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case name = "Name"
        case categoryType = "CategoryType"
        case type = "Type"
        case friendlyName = "FriendlyName"
        case canWithdraw = "CanWithdraw"
        case productHexCode = "ProductHexCode"
        case annualLimit = "AnnualLimit"
        case depositLimit = "DepositLimit"
        case bonusMultiplier = "BonusMultiplier"
        case minimumWeeklyDeposit = "MinimumWeeklyDeposit"
        case maximumWeeklyDeposit = "MaximumWeeklyDeposit"
        case documents = "Documents"
        case state = "State"
        case wrapperDefinitionGlobalID = "WrapperDefinitionGlobalId"
        case lisa = "Lisa"
        case interestRate = "InterestRate"
        case interestRateAmount = "InterestRateAmount"
        case logoURL = "LogoUrl"
        case fund = "Fund"
    }
    
    // MARK: - Properties
    
    public let id: AdoptableID?
    public let name: String?
    public let categoryType: String?
    public let type: String?
    public let friendlyName: String?
    public let canWithdraw: Bool?
    public let productHexCode: String?
    public let annualLimit: Int?
    public let depositLimit: Int?
    public let bonusMultiplier: Double?
    public let minimumWeeklyDeposit: Int?
    public let maximumWeeklyDeposit: Int?
    public let documents: Documents?
    public let state: String?
    public let wrapperDefinitionGlobalID: AdoptableID?
    public let lisa: Lisa?
    public let interestRate: String?
    public let interestRateAmount: Double?
    public let logoURL: String?
    public let fund: Fund?
}

// MARK: - ProductDTO Nested

public extension ProductDTO {
    struct Documents: Decodable, Equatable {
        public let keyFeaturesURL: String?
        
        enum CodingKeys: String, CodingKey {
            case keyFeaturesURL = "KeyFeaturesUrl"
        }
    }
    
    struct Fund: Decodable, Equatable {
        enum CodingKeys: String, CodingKey {
            case fundID = "FundId"
            case name = "Name"
            case logoURL = "LogoUrl"
            case isFundDMB = "IsFundDMB"
        }
        
        public let fundID: AdoptableID?
        public let name: String?
        public let logoURL: String?
        public let isFundDMB: Bool?
    }
    
    struct Lisa: Decodable, Equatable {
        enum CodingKeys: String, CodingKey {
            case maximumBonus = "MaximumBonus"
        }
        
        public let maximumBonus: Int?
    }
}
