//
//  AccountCellModel.swift
//  
//
//  Created by Dmytro Vorko on 23.08.2022.
//

import Foundation
import AppResources

struct AccountCellModel: Equatable {
    // MARK: - Properties
    
    let id: AnyHashable
    let name: String
    let planValue: String
    let moneyBoxValue: String
    
    // MARK: - Constructor
    
    init(id: AnyHashable, name: String, planValue: Double, moneyBoxValue: Double, currency: String) {
        self.id = id
        self.name = name
        self.planValue = Strings.Account.Cell.planValue(currency, String(planValue))
        self.moneyBoxValue = Strings.Account.Cell.moneyboxValue(currency, String(moneyBoxValue))
    }
}
