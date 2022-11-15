//
//  AccountCellModel.swift
//  
//
//  Created by Dmytro Vorko on 23.08.2022.
//

import Foundation
import AppResources

struct AccountCellModel: Hashable {
    // MARK: - Properties
    
    let id: String
    let name: String
    
    private let planValue: String
    private let moneyBoxValue: String
    private let planValueCurrency: String
    private let moneyBoxValueCurrency: String
    
    var planValueText: String {
        Strings.Account.Cell.planValue(planValueCurrency, planValue)
    }
    
    var moneyBoxValueText: String {
        Strings.Account.Cell.moneyboxValue(moneyBoxValueCurrency, moneyBoxValue)
    }
    
    // MARK: - Constructor
    
    init(id: String, name: String, planValue: Double, planValueCurrency: String, moneyBoxValue: Double, moneyBoxValueCurrency: String) {
        self.id = id
        self.name = name
        self.planValue = planValue.format(.roundUp(count: 2))
        self.moneyBoxValue = moneyBoxValue.format(.roundUp(count: 2))
        self.planValueCurrency = planValueCurrency
        self.moneyBoxValueCurrency = moneyBoxValueCurrency
    }
}
