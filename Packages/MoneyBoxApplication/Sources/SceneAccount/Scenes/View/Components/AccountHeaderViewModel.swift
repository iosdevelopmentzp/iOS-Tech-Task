//
//  AccountHeaderViewModel.swift
//  
//
//  Created by Dmytro Vorko on 23.08.2022.
//

import Foundation
import AppResources

struct AccountHeaderViewModel: Equatable {
    // MARK: - Properties
    
    let id: Int
    private let name: String
    private let planValue: Double
    private let currencySymbol: String
    
    var localizedName: String {
        Strings.Account.name(name)
    }
    
    var localizedTotalPlan: String {
        Strings.Account.totalPlan(currencySymbol, String(planValue))
    }
    
    // MARK: - Constuctor
    
    init(id: Int, name: String, planValue: Double, currencySymbol: String) {
        self.id = id
        self.name = name
        self.planValue = planValue
        self.currencySymbol = currencySymbol
    }
}
