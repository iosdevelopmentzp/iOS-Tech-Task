//
//  UserAccount.swift
//  
//
//  Created by Dmytro Vorko on 25/10/2022.
//

import Foundation

public struct UserAccount: Equatable {
    // MARK: - Properties
    
    public let totalPlanValue: Currency?
    public let products: [Product]?
    
    // MARK: - Constructor
    
    public init(totalPlanValue: Currency?, products: [Product]?) {
        self.totalPlanValue = totalPlanValue
        self.products = products
    }
}
