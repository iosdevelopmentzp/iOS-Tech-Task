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
            let totalPlanValue = accountResponse.totalPlanValue.map {
                Currency(value: $0, sign: currencySign)
            }
            
            let accounts = accountResponse
                .accounts?
                .compactMap { accountDTO -> Account? in
                    guard let id = accountDTO.wrapper?.id, !id.isEmpty else { return nil }
                    
                    let accountProducts = accountResponse.productResponses?.filter {
                        guard let wrapperID = $0.wrapperID else { return false }
                        return wrapperID == id
                    } ?? []
                    
                    let planValue = accountProducts.reduce(into: Double(0)){ partialResult, product in
                        partialResult += product.planValue ?? 0
                    }
                    
                    let moneyboxValue = accountProducts.reduce(into: Double(0)) { partialResult, product in
                        partialResult += product.moneybox ?? 0
                    }
                    
                    return .init(
                        id: id,
                        name: accountDTO.name ?? "",
                        planValue: .init(value: planValue, sign: currencySign),
                        moneyboxValue: .init(value: moneyboxValue, sign: currencySign)
                    )
                }
                .sorted(by: { $0.name < $1.name })
            
            
            return UserAccount(
                totalPlanValue: totalPlanValue,
                individualAccounts: accounts
            )
        }
    }
}
