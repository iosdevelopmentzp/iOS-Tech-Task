//
//  TransactionUseCaseProtocol.swift
//  
//
//  Created by Dmytro Vorko on 16/11/2022.
//

import Foundation

public protocol TransactionUseCaseProtocol {
    func oneOffPayment(amount: Int, investorProductID: Int) async throws
}
