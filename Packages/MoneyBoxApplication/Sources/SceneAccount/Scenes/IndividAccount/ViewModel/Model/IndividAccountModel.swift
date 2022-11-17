//
//  IndividAccountModel.swift
//  
//
//  Created by Dmytro Vorko on 17/11/2022.
//

import Foundation
import Core

struct IndividAccountModel: Hashable {
    let id: String
    let name: String
    let planValue: Currency
    let moneyBoxValue: Currency
    let addValue: Currency?
}
