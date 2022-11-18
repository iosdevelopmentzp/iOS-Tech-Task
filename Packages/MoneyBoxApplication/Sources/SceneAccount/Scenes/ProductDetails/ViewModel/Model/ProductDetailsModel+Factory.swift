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
        static func make(_ product: Product, addValue: Double, addCurrency: String) -> ProductDetailsModel {
            return .init(
                id: product.id,
                name: product.name,
                planValue: product.planValue,
                moneyBoxValue: product.moneyboxValue,
                addValue: .init(value: addValue, sign: addCurrency)
            )
        }
    }
}
