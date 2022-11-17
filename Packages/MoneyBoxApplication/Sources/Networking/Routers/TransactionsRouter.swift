//
//  TransactionsRouter.swift
//  
//
//  Created by Dmytro Vorko on 16/11/2022.
//

import Foundation

enum TransactionsRouter {
    case oneOffPayment
}

extension TransactionsRouter: RouteType {
    var method: HTTPMethod {
        switch self {
        case .oneOffPayment:
            return .post
        }
    }
    
    var path: String {
        switch self {
        case .oneOffPayment:
            return "/oneoffpayments"
        }
    }
}
