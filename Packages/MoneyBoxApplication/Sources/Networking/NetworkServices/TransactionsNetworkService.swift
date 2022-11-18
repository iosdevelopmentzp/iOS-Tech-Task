//
//  TransactionsNetworkService.swift
//  
//
//  Created by Dmytro Vorko on 16/11/2022.
//

import Foundation
import Core

public protocol TransactionsNetworkServiceProtocol: AnyObject {
    var tokenProvider: TokenProviderType? { get set }
    
    func oneOffPayment(_ data: OneOffPaymentRequestDTO) async throws -> OneOffPaymentResponseDTO
}

final class TransactionsNetworkService {
    private typealias TransactionsTarget = Target<TransactionsRouter>
    
    weak var tokenProvider: TokenProviderType?
    private let networking: NetworkingProtocol
    private let configurations: NetworkConfigurationsType
    
    init(_ networking: Networking, configurations: NetworkConfigurationsType) {
        self.networking = networking
        self.configurations = configurations
    }
}

// MARK: - AuthorizationNetworkServiceProtocol

extension TransactionsNetworkService: TransactionsNetworkServiceProtocol {
    func oneOffPayment(_ data: OneOffPaymentRequestDTO) async throws -> OneOffPaymentResponseDTO {
        let provider = RequestDataProvider(configurations, parameters: try data.toDictionary(), token: tokenProvider?.authorizationToken())
        let target = TransactionsTarget(provider, router: .oneOffPayment)
        
        let response: MultipleDecodableModel<OneOffPaymentResponseDTO, ErrorResponseDTO>
        response = try await networking.dataRequest(target: target)
        
        return try response.mainExpectationOrError()
    }
}
