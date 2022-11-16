//
//  IndividAccountCellModel+Factory.swift
//  
//
//  Created by Dmytro Vorko on 16/11/2022.
//

import Foundation
import Core

extension IndividAccountCellModel {
    struct Factory {
        static func make(account: Account, individAccountId: String) -> IndividAccountCellModel {
            return .init(
                id: account.id,
                name: account.name,
                planValue: account.planValue.value,
                planValueCurrency: account.planValue.sign,
                moneyBoxValue: account.moneyboxValue.value,
                moneyBoxValueCurrency: account.moneyboxValue.sign
            )
        }
    }
}
