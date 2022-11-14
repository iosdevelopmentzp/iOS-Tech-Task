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
    public let individualAccounts: [Account]?
    
    // MARK: - Constructor
    
    public init(totalPlanValue: Currency?, individualAccounts: [Account]?) {
        self.totalPlanValue = totalPlanValue
        self.individualAccounts = individualAccounts
    }
}
