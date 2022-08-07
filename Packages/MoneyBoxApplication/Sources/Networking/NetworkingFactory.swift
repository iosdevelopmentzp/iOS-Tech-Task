//
//  NetworkingFactory.swift
//  
//
//  Created by Dmytro Vorko on 05.08.2022.
//

import Foundation

public protocol NetworkingFactoryProtocol {
    func authorization(configurations: NetworkConfigurationsType) -> AuthorizationNetworkServiceProtocol
    
    func account(configurations: NetworkConfigurationsType) -> AccountNetworkServiceProtocol
}

public final class NetworkingFactory {
    public init() {}
}

// MARK: - NetworkingFactoryProtocol

extension NetworkingFactory: NetworkingFactoryProtocol {
    public func authorization(configurations: NetworkConfigurationsType) -> AuthorizationNetworkServiceProtocol {
        AuthorizationNetworkService(Networking(), configurations: configurations)
    }
    
    public func account(configurations: NetworkConfigurationsType) -> AccountNetworkServiceProtocol {
        AccountNetworkService(Networking(), configurations: configurations)
    }
}
