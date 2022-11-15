//
//  AccountHeaderCellModel.swift
//  
//
//  Created by Dmytro Vorko on 23.08.2022.
//

import Foundation
import AppResources

struct AccountHeaderCellModel: Hashable {
    // MARK: - Properties
    
    let name: String
    private let planValue: Double
    private let currency: String
    
    var planValueText: String {
        Strings.Account.totalPlan(currency, String(planValue))
    }
    
    // MARK: - Constuctor
    
    init(name: String, planValue: Double, currency: String) {
        self.name = Strings.Account.name(name)
        self.planValue = planValue
        self.currency = currency
    }
}
