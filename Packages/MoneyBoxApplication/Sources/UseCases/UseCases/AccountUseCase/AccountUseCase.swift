//
//  AccountUseCase.swift
//  
//
//  Created by Dmytro Vorko on 07.08.2022.
//

import Foundation
import Core
import Networking

final class AccountUseCase {
    private let networking: AccountNetworkServiceProtocol
    
    init(_ networking: AccountNetworkServiceProtocol) {
        self.networking = networking
    }
}

// MARK: - AccountUseCaseProtocol

extension AccountUseCase: AccountUseCaseProtocol {
    func products() async throws -> [Int] {
        let account = try await networking.account()
        return account.productResponses?.map(\.id) ?? []
    }
}
