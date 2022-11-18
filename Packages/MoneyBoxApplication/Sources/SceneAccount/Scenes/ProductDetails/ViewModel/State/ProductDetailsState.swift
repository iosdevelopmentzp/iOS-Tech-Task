//
//  ProductDetailsState.swift
//  
//
//  Created by Dmytro Vorko on 16/11/2022.
//

import Foundation
import Extensions

enum ProductDetailsState: Hashable {
    case idle
    case loading
    case failedLoading(_ errorMessage: String)
    case loaded(_ model: ProductDetailsModel)
    case transactionLoading(_ model: ProductDetailsModel)
    case successTransaction(_ description: String, _ model: ProductDetailsModel)
    case failedTransaction(_ errorMessage: String, _ models: ProductDetailsModel)
}

// MARK: - Extensions

extension ProductDetailsState {
    var model: ProductDetailsModel? {
        switch self {
            
        case .idle, .loading, .failedLoading:
            return nil
            
        case .loaded(let model),
                .transactionLoading(let model),
                .successTransaction(_, let model),
                .failedTransaction(_, let model):
            return model
        }
    }
    
    var isIdle: Bool {
        switch self {
        case .idle:
            return true
        
        default:
            return false
        }
    }
}
