//
//  ProductDetailsButtonModel.swift
//  
//
//  Created by Dmytro Vorko on 15/11/2022.
//

import Foundation

struct ProductDetailsButtonModel: Hashable {
    enum State: Hashable {
        case active(_ title: String)
        case hidden
        case loading
        case inactive(_ title: String)
    }
    
    let state: State
}
