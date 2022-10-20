//
//  AccountHeaderCellModel.swift
//  
//
//  Created by Dmytro Vorko on 23.08.2022.
//

import Foundation
import AppResources

struct AccountHeaderCellModel: Equatable {
    // MARK: - Properties
    
    let name: String
    let planValue: String
    
    // MARK: - Constuctor
    
    init(name: String, planValue: Double, currencySymbol: String) {
        self.name = Strings.Account.name(name)
        self.planValue = Strings.Account.totalPlan(currencySymbol, String(planValue))
    }
}
