//
//  NetworkLogListener.swift
//  
//
//  Created by Dmytro Vorko on 21/10/2022.
//

import Foundation

struct NetworkLogListener: NetworkListenerProtocol {
    func dataRequest(target: TargetType, didChangeState newState: DataRequestState) {
        debugPrint("DEBUG: url: \(try! target.asURL()) Did change state: \(newState)")
    }
}
