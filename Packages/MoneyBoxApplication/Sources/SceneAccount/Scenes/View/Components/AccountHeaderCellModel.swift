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
    private let planValue: String
    private let currency: String
    
    var planValueText: String {
        Strings.Account.totalPlan(currency, planValue)
    }
    
    // MARK: - Constuctor
    
    init(name: String, planValue: Double, currency: String) {
        self.name = Strings.Account.name(name)
        self.planValue = planValue.format(.roundUp(count: 2))
        self.currency = currency
    }
}
