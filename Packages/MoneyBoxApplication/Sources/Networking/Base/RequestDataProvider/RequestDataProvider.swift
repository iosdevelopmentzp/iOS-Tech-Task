//
//  RequestDataProvider.swift
//  
//
//  Created by Dmytro Vorko on 05.08.2022.
//

import Foundation

struct RequestDataProvider: RequestDataProviderType {
    // MARK: - RequestDataProviderType
    
    let token: String?
    
    let parameters: [String : Any]?
    
    var host: String {
        configurations.host
    }
    
    var headers: [String : String]? {
        var headers = configurations.configurationHeaders
        
        if let token = token {
            headers["Authorization"] = "Bearer \(token)"
        }
        
        return headers
    }
    
    // MARK: - Private Properties
    
    private let configurations: NetworkConfigurationsType
    
    // MARK: - Constructor
    
    init(
        _ configurations: NetworkConfigurationsType,
        parameters: [String: Any]? = nil,
        token: String? = nil
    ) {
        self.configurations = configurations
        self.parameters = parameters
        self.token = token
    }
}
