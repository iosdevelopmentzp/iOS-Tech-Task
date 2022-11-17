//
//  AccountRouter.swift
//  
//
//  Created by Dmytro Vorko on 06.08.2022.
//

import Foundation

enum AccountRouter {
    case products
}

extension AccountRouter: RouteType {
    var method: HTTPMethod {
        switch self {
        case .products:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .products:
            return "/investorproducts"
        }
    }
}
