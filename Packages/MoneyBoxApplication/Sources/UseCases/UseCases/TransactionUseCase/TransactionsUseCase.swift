//
//  TransactionsUseCase.swift
//  
//
//  Created by Dmytro Vorko on 16/11/2022.
//

import Foundation
import Core
import Networking
import SettingsStorage

final class TransactionsUseCase {
    private let networking: TransactionsNetworkServiceProtocol
    
    private let authorizationTokenProvider: AuthorizationTokenProviderProtocol
    
    init(
        networking: TransactionsNetworkServiceProtocol,
        authorizationTokenProvider: AuthorizationTokenProviderProtocol
    ) {
        self.networking = networking
        self.authorizationTokenProvider = authorizationTokenProvider
        self.networking.tokenProvider = self
    }
}

// MARK: - TransactionUseCaseProtocol

extension TransactionsUseCase: TransactionsUseCaseProtocol {
    func oneOffPayment(amount: Int, investorProductID: Int) async throws {
        try await _ = networking.oneOffPayment(.init(amount: amount, investorProductID: investorProductID))
    }
}

// MARK: - Token Provider

extension TransactionsUseCase: TokenProviderType {
    func authorizationToken() -> String? {
        self.authorizationTokenProvider.authorizationToken
    }
}
