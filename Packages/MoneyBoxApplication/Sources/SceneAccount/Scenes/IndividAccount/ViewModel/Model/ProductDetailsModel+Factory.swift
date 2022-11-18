//
//  ProductDetailsModel+Factory.swift
//  
//
//  Created by Dmytro Vorko on 17/11/2022.
//

import Foundation
import Core

extension ProductDetailsModel {
    struct Factory {
        static func make(_ account: Product, addValue: Double, addCurrency: String) -> ProductDetailsModel {
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
