//
//  AuthorizationRouter.swift
//  
//
//  Created by Dmytro Vorko on 06.08.2022.
//

import Foundation
import Moya

enum AuthorizationRouter {
    case login
}

extension AuthorizationRouter: RouteType {
    var method: Moya.Method {
        switch self {
        case .login:
            return .post
        }
    }
    
    var path: String {
        switch self {
        case .login:
            return "/users/login"
        }
    }
}
