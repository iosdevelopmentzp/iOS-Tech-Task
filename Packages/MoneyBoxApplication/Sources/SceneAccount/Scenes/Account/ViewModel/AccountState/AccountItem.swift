//
//  AccountItem.swift
//  
//
//  Created by Dmytro Vorko on 25/10/2022.
//

import Foundation

enum AccountItem: Equatable {
    case product(_ vieModel: ProductCellModel)
    case header(_ vieModel: AccountHeaderCellModel)
}
