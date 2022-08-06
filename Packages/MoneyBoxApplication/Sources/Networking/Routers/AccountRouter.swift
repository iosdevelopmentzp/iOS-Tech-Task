//
//  AccountRouter.swift
//  
//
//  Created by Dmytro Vorko on 06.08.2022.
//

import Foundation
import Alamofire

enum AccountRouter {
    case products
    case addMoney
}

extension AccountRouter: RouteType {
    var method: Alamofire.HTTPMethod {
        switch self {
        case .products:
            return .get
            
        case .addMoney:
            return .post
        }
    }
    
    var path: String {
        switch self {
        case .products:
            return "/investorproducts"
        
        case .addMoney:
            return "/oneoffpayments"
        }
    }
}
