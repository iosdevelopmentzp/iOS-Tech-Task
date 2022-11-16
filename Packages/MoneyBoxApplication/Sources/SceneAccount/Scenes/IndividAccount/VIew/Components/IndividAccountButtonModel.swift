//
//  IndividAccountButtonModel.swift
//  
//
//  Created by Dmytro Vorko on 15/11/2022.
//

import Foundation

struct IndividAccountButtonModel: Hashable {
    enum State: Hashable {
        case active(_ title: String)
        case hidden
        case loading
    }
    
    let state: State
}
