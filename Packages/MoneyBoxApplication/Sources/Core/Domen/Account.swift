//
//  Account.swift
//  
//
//  Created by Dmytro Vorko on 24.08.2022.
//

import Foundation

public struct Account: Equatable {
    // MARK: - Properties
    
    public let id: String
    public let name: String
    public let planValue: Currency
    public let moneyboxValue: Currency
    
    // MARK: - Constructor
    
    public init(id: String, name: String, planValue: Currency, moneyboxValue: Currency) {
        
        self.id = id
        self.name = name
        self.planValue = planValue
        self.moneyboxValue = moneyboxValue
    }
}
