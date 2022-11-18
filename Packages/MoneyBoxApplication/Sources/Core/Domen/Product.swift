//
//  Product.swift
//  
//
//  Created by Dmytro Vorko on 24.08.2022.
//

import Foundation

public struct Product: Equatable {
    // MARK: - Properties
    
    public let id: Int
    public let name: String
    public let planValue: Currency
    public let moneyboxValue: Currency
    
    // MARK: - Constructor
    
    public init(id: Int, name: String, planValue: Currency, moneyboxValue: Currency) {
        
        self.id = id
        self.name = name
        self.planValue = planValue
        self.moneyboxValue = moneyboxValue
    }
}
