//
//  ProductCellModel.swift
//  
//
//  Created by Dmytro Vorko on 23.08.2022.
//

import Foundation
import AppResources

struct ProductCellModel: Hashable {
    // MARK: - Properties
    
    let id: Int
    let name: String
    let planValue: String
    let moneyBoxValue: String
    
    // MARK: - Constructor
    
    init(id: Int, name: String, planValue: Double, moneyBoxValue: Double, currencySymbol: String) {
        self.id = id
        self.name = name
        self.planValue = Strings.Account.Cell.planValue(currencySymbol, String(planValue))
        self.moneyBoxValue = Strings.Account.Cell.moneyboxValue(currencySymbol, String(moneyBoxValue))
    }
}
