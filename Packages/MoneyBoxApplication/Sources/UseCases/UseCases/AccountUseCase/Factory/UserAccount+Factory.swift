//
//  UserAccount+Factory.swift
//  
//
//  Created by Dmytro Vorko on 25/10/2022.
//

import Core

extension UserAccount {
    struct Factory {
        private static let currencySign = "£"
        
        static func make(_ accountResponse: AccountResponseDTO) -> UserAccount {
            let totalPlanValue = Currency(value: accountResponse.totalPlanValue, sign: currencySign)
            
            let products = (accountResponse.productResponses ?? []).map { productDTO -> Product in
                    .init(
                        id: productDTO.id,
                        name: productDTO.product.name,
                        planValue: .init(value: productDTO.planValue, sign: currencySign),
                        moneyboxValue: .init(value: productDTO.moneybox, sign: currencySign)
                    )
            }.sorted(by: { $0.name < $1.name })
            
            return UserAccount(
                totalPlanValue: totalPlanValue,
                products: products
            )
        }
    }
}
