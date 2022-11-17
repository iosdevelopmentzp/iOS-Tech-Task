//
//  IndividAccountModel+Factory.swift
//  
//
//  Created by Dmytro Vorko on 17/11/2022.
//

import Foundation
import Core

extension IndividAccountModel {
    struct Factory {
        static func make(_ account: Account, addValue: Double, addCurrency: String) -> IndividAccountModel {
            return .init(
                id: account.id,
                name: account.name,
                planValue: account.planValue,
                moneyBoxValue: account.moneyboxValue,
                addValue: .init(value: addValue, sign: addCurrency)
            )
        }
    }
}
