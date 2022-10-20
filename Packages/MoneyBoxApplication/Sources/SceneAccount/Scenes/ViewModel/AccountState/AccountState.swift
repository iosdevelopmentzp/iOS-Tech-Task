//
//  AccountState.swift
//  
//
//  Created by Dmytro Vorko on 24.08.2022.
//

import Foundation

struct AccountHeaderViewModel: Equatable {
    
}

enum AccountState: Equatable {
    case idle
    case loading
    case error(_ errorMessage: String)
    case loaded(_ productsModels: [ProductCellModel], _ headerModel: AccountHeaderViewModel)
}

extension AccountState {
    var productsModels: [ProductCellModel]? {
        guard case .loaded(let productsModels, _) = self else {
            return nil
        }
        return productsModels
    }
    
    var headerModel: AccountHeaderViewModel? {
        guard case .loaded(_, let headerModel) = self else {
            return nil
        }
        return headerModel
    }
}
