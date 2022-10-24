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
    private lazy var lock = NSLock()
    
    // MARK: - Constructor
    
    init(
        _ session: URLSession = .shared,
        listeners: [NetworkListenerProtocol] = [NetworkLogListener()]
    ) {
        self.session = session
        self.listeners = listeners
    }
    
    // MARK: - Private
    
    private func notifyListeners(target: TargetType, didChangeState newState: DataRequestState) {
        guard !listeners.isEmpty else { return }
        lock.lock()
        listeners.forEach { $0.dataRequest(target: target, didChangeState: newState) }
        lock.unlock()
    }
}

// MARK: - NetworkingProtocol

extension Networking: NetworkingProtocol {
    func dataRequest<R: Decodable>(target: TargetType, decoder: JSONDecoder) async throws -> R {
        // Preparing for request
        let request: URLRequest
        do {
            request = try target.asURLRequest()
            notifyListeners(target: target, didChangeState: .willBeSent(request))
        } catch {
            notifyListeners(target: target, didChangeState: .invalidTarget(error))
            throw error
        }
        
        let startDate = Date()
        // Make a request
        let response: (data: Data, response: URLResponse)
        do {
            response = try await session.data(for: request)
            let endDate = Date()
            let duration = endDate - startDate
            notifyListeners(
                target: target,
                didChangeState: .serverResponse(request, response.response, response.data, duration)
            )
        } catch {
            notifyListeners(target: target, didChangeState: .requestError(request, error))
            throw error
        }
        
        // Try decode response data
        let decodedModel: R
        do {
            decodedModel = try decoder.decode(R.self, from: response.data)
            notifyListeners(target: target, didChangeState: .decodedModel(decodedModel))
        } catch {
            notifyListeners(target: target, didChangeState: .failedDecoding(error))
            throw error
        }
        
        return decodedModel
    }
}

// MARK: - Date Extra

private extension Date {
    static func - (lhs: Date, rhs: Date) -> TimeInterval {
        return lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
    }

}
