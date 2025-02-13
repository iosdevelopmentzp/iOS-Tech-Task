//
//  ProductDetailsModel.swift
//  
//
//  Created by Dmytro Vorko on 17/11/2022.
//

import Foundation
import Core

struct ProductDetailsModel: Hashable {
    let id: Int
    let name: String
    let planValue: Currency
    let moneyBoxValue: Currency
    let addValue: Currency?
}
