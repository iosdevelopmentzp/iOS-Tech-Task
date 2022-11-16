//
//  IndividAccountItem.swift
//  
//
//  Created by Dmytro Vorko on 16/11/2022.
//

import Foundation

enum IndividAccountItem: Hashable {
    case loading
    case error(_ message: String)
    case account(_ model: IndividAccountCellModel)
}
