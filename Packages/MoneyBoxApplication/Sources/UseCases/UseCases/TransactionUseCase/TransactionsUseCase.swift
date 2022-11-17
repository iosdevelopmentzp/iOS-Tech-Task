//
//  TransactionUseCase.swift
//  
//
//  Created by Dmytro Vorko on 16/11/2022.
//

import Foundation
import Core
import Networking

final class TransactionUseCase {
    private let networking: TransactionsNetworkServiceProtocol
    
    init(networking: TransactionsNetworkServiceProtocol) {
        self.networking = networking
    }
}

// MARK: - TransactionUseCaseProtocol

extension TransactionUseCase: TransactionUseCaseProtocol {
    func oneOffPayment(amount: Int, investorProductID: Int) async throws {
        try await _ = networking.oneOffPayment(.init(amount: amount, investorProductID: investorProductID))
    }
}
