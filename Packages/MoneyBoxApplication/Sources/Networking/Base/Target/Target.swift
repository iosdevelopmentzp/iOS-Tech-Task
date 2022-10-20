//
//  Target.swift
//  
//
//  Created by Dmytro Vorko on 05.08.2022.
//

import Foundation

protocol RouteType {
    var method: HTTPMethod { get }
    var path: String { get }
}

struct Target<Router: RouteType> {
    private let sendDataProvider: RequestDataProviderType
    private let router: Router
    
    init(_ provider: RequestDataProviderType, router: Router) {
        self.sendDataProvider = provider
        self.router = router
    }
}

// MARK: - TargetType

extension Target: TargetType {
    var host: String {
        sendDataProvider.host
    }
    
    var path: String {
        router.path
    }
    
    var method: HTTPMethod {
        router.method
    }
    
    var headers: [String : String]? {
        sendDataProvider.headers
    }
    
    var parameters: [String : Any]? {
        sendDataProvider.parameters
    }
}
