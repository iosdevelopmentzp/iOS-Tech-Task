//
//  AccountNetworkService.swift
//  
//
//  Created by Dmytro Vorko on 06.08.2022.
//

import Foundation
import Moya
import Core

public protocol AccountNetworkServiceProtocol {
    
}

final class AccountNetworkService {
    private typealias AccountTarget = Target<AccountRouter>
    
    private let networking: Networking
    
    init(_ networking: Networking) {
        self.networking = networking
    }
}

// MARK: - AccountNetworkServiceProtocol

extension AccountNetworkService: AccountNetworkServiceProtocol {
    
}
