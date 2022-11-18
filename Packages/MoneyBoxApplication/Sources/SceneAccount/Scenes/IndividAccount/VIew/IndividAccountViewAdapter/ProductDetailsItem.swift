//
//  ProductDetailsItem.swift
//  
//
//  Created by Dmytro Vorko on 16/11/2022.
//

import Foundation

enum ProductDetailsItem: Hashable {
    case loading
    case error(_ message: String)
    case account(_ model: ProductDetailsCellModel)
}
