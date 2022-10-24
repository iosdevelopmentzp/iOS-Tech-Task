//
//  NetworkListenerProtocol.swift
//  
//
//  Created by Dmytro Vorko on 21/10/2022.
//

import Foundation

public enum DataRequestState {
    case invalidTarget(_ error: Error)
    case willBeSent(_ request: URLRequest)
    case serverResponse(_ request: URLRequest, _ response: URLResponse?, _ data: Data?, _ duration: TimeInterval)
    case requestError(_ request: URLRequest, _ error: Error)
    case failedDecoding(_ error: Error)
    case decodedModel(_ model: Decodable)
}

public protocol NetworkListenerProtocol {
    func dataRequest(target: TargetType, didChangeState newState: DataRequestState)
}
