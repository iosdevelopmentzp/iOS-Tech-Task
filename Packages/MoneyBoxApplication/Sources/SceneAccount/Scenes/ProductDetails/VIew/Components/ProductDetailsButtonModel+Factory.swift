//
//  ProductDetailsButtonModel+Factory.swift
//  
//
//  Created by Dmytro Vorko on 17/11/2022.
//

import Foundation
import AppResources
import Core
import Extensions

extension ProductDetailsButtonModel {
    struct Factory {
        static func make(_ state: ProductDetailsState) -> ProductDetailsButtonModel {
            let buttonState: ProductDetailsButtonModel.State
            
            let buttonTitleConstructor: ArgAdjClosure<Currency, String> = {
                let addValue = $0.value.format(.roundUp(count: 0))
                return Strings.ProductDetails.add($0.sign, addValue)
            }
            
            switch state {
            case .idle, .loading, .failedLoading:
                buttonState = .hidden
            
            case .loaded(let model):
                let title = model.addValue.map { buttonTitleConstructor($0) } ?? ""
                buttonState = .active(title)
                
            case .transactionLoading:
                buttonState = .loading
                
            case .successTransaction(_, let model),
                    .failedTransaction(_, let model):
                let title = model.addValue.map { buttonTitleConstructor($0) } ?? ""
                buttonState = .inactive(title)
            }
            
            return .init(state: buttonState)
        }
    }
}
