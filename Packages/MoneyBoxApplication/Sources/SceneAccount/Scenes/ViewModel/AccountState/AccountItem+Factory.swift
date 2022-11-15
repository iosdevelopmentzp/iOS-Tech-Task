//
//  AccountItem+Factory.swift
//  
//
//  Created by Dmytro Vorko on 14/11/2022.
//

import Foundation
import Core

extension AccountItem {
    struct Factory {
        static func make(account: UserAccount, userName: String) -> [AccountItem] {
            let header = AccountHeaderCellModel(
                name: userName,
                planValue: account.totalPlanValue?.value ?? 0,
                currency: account.totalPlanValue?.sign ?? ""
            )
            
            let accounts: [AccountCellModel] = account.individualAccounts?.map {
                .init(
                    id: $0.id,
                    name: $0.name,
                    planValue: $0.planValue.value,
                    planValueCurrency: $0.planValue.sign,
                    moneyBoxValue: $0.moneyboxValue.value,
                    moneyBoxValueCurrency: $0.moneyboxValue.sign
                )
            } ?? []
            
            return [.header(header)] + accounts.map { .individualAccount($0) }
        }
    }
}
