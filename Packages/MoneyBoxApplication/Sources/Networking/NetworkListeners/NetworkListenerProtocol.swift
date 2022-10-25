//
//  NetworkListenerProtocol.swift
//  
//
//  Created by Dmytro Vorko on 21/10/2022.
//

import Foundation

public typealias RequestID = AnyHashable

public enum DataRequestState {
    case invalidTarget(_ error: Error)
    case willBeSent(_ request: URLRequest)
    case serverResponse(_ request: URLRequest, _ response: URLResponse?, _ data: Data?)
    case requestError(_ request: URLRequest, _ error: Error)
    case failedDecoding(_ error: Error)
    case decodedModel(_ model: Decodable)
}

public protocol NetworkListenerProtocol {
    func dataRequest(with id: AnyHashable, target: TargetType, didChangeState newState: DataRequestState)
}
