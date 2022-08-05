//
//  AccountDTO.swift
//  
//
//  Created by Dmytro Vorko on 05.08.2022.
//

import Foundation

public struct AccountDTO: Decodable, Equatable {
    // MARK: - Nested
    
    enum CodingKeys: String, CodingKey {
        case type = "Type"
        case name = "Name"
        case deepLinkIdentifier = "DeepLinkIdentifier"
        case wrapper = "Wrapper"
        case milestone = "Milestone"
        case hasCollections = "HasCollections"
    }
    
    public struct Milestone: Decodable, Equatable {
        enum CodingKeys: String, CodingKey {
            case initialStage = "InitialStage"
            case endStage = "EndStage"
            case endStageID = "EndStageId"
        }
        
        public let initialStage: String?
        public let endStage: String?
        public let endStageID: Int?
    }
    
    public struct Wrapper: Decodable, Equatable {
        enum CodingKeys: String, CodingKey {
            case id = "Id"
            case definitionGlobalID = "DefinitionGlobalId"
            case totalValue = "TotalValue"
            case totalContributions = "TotalContributions"
            case earningsNet = "EarningsNet"
            case earningsAsPercentage = "EarningsAsPercentage"
            case returns = "Returns"
        }
        
        public let id: String?
        public let definitionGlobalID: String?
        public let totalValue: Double?
        public let totalContributions: Int?
        public let earningsNet: Double?
        public let earningsAsPercentage: Double?
        public let returns: Returns?
    }
    
    public struct Returns: Decodable, Equatable {
        enum CodingKeys: String, CodingKey {
            case simple = "Simple"
            case lifetime = "Lifetime"
            case annualised = "Annualised"
        }
        
        public let simple: Double?
        public let lifetime: Double?
        public let annualised: Double?
    }
    
    // MARK: - Properties
    
    public let type: String?
    public let name: String?
    public let deepLinkIdentifier: String?
    public let wrapper: Wrapper?
    public let milestone: Milestone?
    public let hasCollections: Bool?
}
