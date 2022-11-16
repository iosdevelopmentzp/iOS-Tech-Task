//
//  IndividAccountState.swift
//  
//
//  Created by Dmytro Vorko on 16/11/2022.
//

import Foundation

enum IndividAccountState: Hashable {
    struct ModelsContainer: Hashable {
        let buttonModel: IndividAccountButtonModel
        let cellModel: IndividAccountCellModel
    }
    
    case idle
    case loading
    case failedLoading(_ errorMessage: String)
    case loaded(_ models: ModelsContainer)
    case transactionLoading(_ models: ModelsContainer)
    case failedTransaction(_ errorMessage: String, _ models: ModelsContainer)
}
