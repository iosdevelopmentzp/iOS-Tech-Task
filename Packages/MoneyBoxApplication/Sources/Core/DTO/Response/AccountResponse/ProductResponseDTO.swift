//
//  ProductResponseDTO.swift
//  
//
//  Created by Dmytro Vorko on 05.08.2022.
//

import Foundation

public struct ProductResponseDTO: Decodable, Equatable {
    // MARK: - Nested
    
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case assetBoxGlobalID = "AssetBoxGlobalId"
        case planValue = "PlanValue"
        case moneybox = "Moneybox"
        case subscriptionAmount = "SubscriptionAmount"
        case totalFees = "TotalFees"
        case isSelected = "IsSelected"
        case isFavourite = "IsFavourite"
        case collectionDayMessage = "CollectionDayMessage"
        case wrapperID = "WrapperId"
        case isCashBox = "IsCashBox"
        case pendingInstantBankTransferAmount = "PendingInstantBankTransferAmount"
        case assetBox = "AssetBox"
        case product = "Product"
        case investorAccount = "InvestorAccount"
        case personalisation = "Personalisation"
        case contributions = "Contributions"
        case moneyboxCircle = "MoneyboxCircle"
        case isSwitchVisible = "IsSwitchVisible"
        case state = "State"
        case dateCreated = "DateCreated"
    }
    
    // MARK: - Properties
    
    public let id: Int
    public let assetBoxGlobalID: String?
    public let planValue: Double?
    public let moneybox: Double?
    public let subscriptionAmount: Int?
    public let totalFees: Double?
    public let isSelected: Bool?
    public let isFavourite: Bool?
    public let collectionDayMessage: String?
    public let wrapperID: String?
    public let isCashBox: Bool?
    public let pendingInstantBankTransferAmount: Int?
    public let assetBox: AssetBox?
    public let product: ProductDTO?
    public let investorAccount: InvestorAccount?
    public let personalisation: Personalisation?
    public let contributions: Contributions?
    public let moneyboxCircle: MoneyboxCircle?
    public let isSwitchVisible: Bool?
    public let state: String?
    public let dateCreated: String?
}

// MARK: - ProductResponseDTO Nested

public extension ProductResponseDTO {
    struct AssetBox: Decodable, Equatable {
        public let title: String?
        
        enum CodingKeys: String, CodingKey {
            case title = "Title"
        }
    }
    
    struct Contributions: Decodable, Equatable {
        enum CodingKeys: String, CodingKey {
            case status = "Status"
        }
        
        public let status: String?
    }
    
    struct InvestorAccount: Decodable, Equatable {
        enum CodingKeys: String, CodingKey {
            case contributionsNet = "ContributionsNet"
            case earningsNet = "EarningsNet"
            case earningsAsPercentage = "EarningsAsPercentage"
            case todaysInterest = "TodaysInterest"
        }
        
        public let contributionsNet: Double?
        public let earningsNet: Double?
        public let earningsAsPercentage: Double?
        public let todaysInterest: Double?
    }
    
    struct MoneyboxCircle: Decodable, Equatable {
        enum CodingKeys: String, CodingKey {
            case state = "State"
        }
        
        public let state: String?
    }
    
    struct Personalisation: Decodable, Equatable {
        enum CodingKeys: String, CodingKey {
            case quickAddDeposit = "QuickAddDeposit"
            case hideAccounts = "HideAccounts"
        }
        
        public let quickAddDeposit: QuickAddDeposit?
        public let hideAccounts: HideAccounts?
    }
    
    struct HideAccounts: Decodable, Equatable {
        enum CodingKeys: String, CodingKey {
            case enabled = "Enabled"
            case isHidden = "IsHidden"
            case sequence = "Sequence"
        }
        
        public let enabled: Bool?
        public let isHidden: Bool?
        public let sequence: Int?
    }
    
    struct QuickAddDeposit: Decodable, Equatable {
        enum CodingKeys: String, CodingKey {
            case amount = "Amount"
        }
        
        public let amount: Int?
    }
}
