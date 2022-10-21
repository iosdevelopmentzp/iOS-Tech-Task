//
//  NetworkListenerProtocol.swift
//  
//
//  Created by Dmytro Vorko on 21/10/2022.
//

import Foundation

public enum DataRequestState {
    case invalidTarget(error: Error)
    case willBeSent
    case serverResponse(_ response: URLResponse?, _ data: Data?)
    case requestError(_ error: Error)
    case failedDecoding(_ error: Error)
    case decodedModel(_ model: Decodable)
}

public protocol NetworkListenerProtocol {
    func dataRequest(target: TargetType, didChangeState newState: DataRequestState)
}
