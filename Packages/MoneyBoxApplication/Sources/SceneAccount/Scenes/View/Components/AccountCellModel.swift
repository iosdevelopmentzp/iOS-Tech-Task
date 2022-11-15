//
//  AccountCellModel.swift
//  
//
//  Created by Dmytro Vorko on 23.08.2022.
//

import Foundation
import AppResources
import Core

struct AccountCellModel: Hashable {
    // MARK: - Properties
    
    let id: AdoptableID
    let name: String
    
    private let planValue: Double
    private let moneyBoxValue: Double
    private let planValueCurrency: String
    private let moneyBoxValueCurrency: String
    
    var planValueText: String {
        Strings.Account.Cell.planValue(planValueCurrency, String(planValue))
    }
    
    var moneyBoxValueText: String {
        Strings.Account.Cell.moneyboxValue(moneyBoxValueCurrency, String(moneyBoxValue))
    }
    
    // MARK: - Constructor
    
    init(id: AdoptableID, name: String, planValue: Double, planValueCurrency: String, moneyBoxValue: Double, moneyBoxValueCurrency: String) {
        self.id = id
        self.name = name
        self.planValue = planValue
        self.moneyBoxValue = moneyBoxValue
        self.planValueCurrency = planValueCurrency
        self.moneyBoxValueCurrency = moneyBoxValueCurrency
    }
}
