//
//  Target.swift
//  
//
//  Created by Dmytro Vorko on 05.08.2022.
//

import Foundation
import Alamofire

protocol RouteType {
    var method: Alamofire.HTTPMethod { get }
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
    enum TargetTypeError: Swift.Error {
        case invalidComponents
    }
    
    var host: String {
        sendDataProvider.host
    }
    
    var path: String {
        router.path
    }
    
    var method: Alamofire.HTTPMethod {
        router.method
    }
    
    var headers: [String : String]? {
        sendDataProvider.headers
    }
    
    var parameters: [String : Any]? {
        sendDataProvider.parameters
    }
    
    func asURL() throws -> URL {
        var components = URLComponents()
        components.host = self.host
        components.path = self.path
        components.scheme = self.scheme
        
        guard let url = components.url else {
            throw TargetTypeError.invalidComponents
        }
        return url
    }
}
