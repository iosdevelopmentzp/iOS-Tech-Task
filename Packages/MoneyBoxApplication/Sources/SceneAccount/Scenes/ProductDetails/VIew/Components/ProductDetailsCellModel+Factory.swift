//
//  ProductDetailsCellModel+Factory.swift
//  
//
//  Created by Dmytro Vorko on 16/11/2022.
//

import Foundation
import Core

extension ProductDetailsCellModel {
    struct Factory {
        static func make(model: ProductDetailsModel) -> ProductDetailsCellModel {
            return .init(
                id: model.id,
                name: model.name,
                planValue: model.planValue.value,
                planValueCurrency: model.planValue.sign,
                moneyBoxValue: model.moneyBoxValue.value,
                moneyBoxValueCurrency: model.moneyBoxValue.sign
            )
        }
    }
}
