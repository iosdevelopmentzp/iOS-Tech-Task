//
//  Networking.swift
//  
//
//  Created by Dmytro Vorko on 06.08.2022.
//

import Foundation

/// Base Util to perform requests
final class Networking {
    // MARK: - Properties
    
    private let session: URLSession
    private let listeners: [NetworkListenerProtocol]
    
    // MARK: - Constructor
    
    init(
        _ session: URLSession = .shared,
        listeners: [NetworkListenerProtocol] = [NetworkLogListener()]
    ) {
        self.session = session
        self.listeners = listeners
    }
    
    // MARK: - Private
    
    private func notifyListeners(requestId: Int, target: TargetType, didChangeState newState: DataRequestState) {
        listeners.forEach { $0.dataRequest(with: requestId, target: target, didChangeState: newState) }
    }
}

// MARK: - NetworkingProtocol

extension Networking: NetworkingProtocol {
    func dataRequest<R: Decodable>(target: TargetType, decoder: JSONDecoder) async throws -> R {
        let requestId = UUID().hashValue
        
        // Preparing for request
        let request: URLRequest
        do {
            request = try target.asURLRequest()
            notifyListeners(requestId: requestId, target: target, didChangeState: .willBeSent(request))
        } catch {
            notifyListeners(requestId: requestId, target: target, didChangeState: .invalidTarget(error))
            throw error
        }
        
        // Make a request
        let response: (data: Data, response: URLResponse)
        do {
            response = try await session.data(for: request)
            notifyListeners(
                requestId: requestId,
                target: target,
                didChangeState: .serverResponse(request, response.response, response.data)
            )
        } catch {
            notifyListeners(requestId: requestId, target: target, didChangeState: .requestError(request, error))
            throw error
        }
        
        // Try decode response data
        let decodedModel: R
        do {
            decodedModel = try decoder.decode(R.self, from: response.data)
            notifyListeners(requestId: requestId, target: target, didChangeState: .decodedModel(decodedModel))
        } catch {
            notifyListeners(requestId: requestId, target: target, didChangeState: .failedDecoding(error))
            throw error
        }
        
        return decodedModel
    }
}
