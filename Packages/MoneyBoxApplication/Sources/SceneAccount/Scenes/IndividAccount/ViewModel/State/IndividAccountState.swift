//
//  IndividAccountState.swift
//  
//
//  Created by Dmytro Vorko on 16/11/2022.
//

import Foundation

enum IndividAccountState: Hashable {
    case idle
    case loading
    case failedLoading(_ errorMessage: String)
    case loaded(_ model: IndividAccountModel)
    case transactionLoading(_ model: IndividAccountModel)
    case successTransaction(_ model: IndividAccountModel)
    case failedTransaction(_ errorMessage: String, _ models: IndividAccountModel)
}

// MARK: - Extensions

extension IndividAccountState {
    var model: IndividAccountModel? {
        switch self {
            
        case .idle, .loading, .failedLoading:
            return nil
            
        case .loaded(let model),
                .transactionLoading(let model),
                .successTransaction(let model),
                .failedTransaction(_, let model):
            return model
        }
    }
}
