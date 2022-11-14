//
//  AccountCellModel+Factory.swift
//  
//
//  Created by Dmytro Vorko on 25/10/2022.
//

import Foundation
import Core

extension AccountCellModel {
    struct Factory {
        static func make(_ accounts: [Account]) -> [AccountCellModel] {
            accounts.map {
                .init(
                    id: $0.id,
                    name: $0.name,
                    planValue: $0.planValue.value,
                    moneyBoxValue: $0.moneyboxValue.value,
                    currency: $0.planValue.sign
                )
            }
        }
    }
}
