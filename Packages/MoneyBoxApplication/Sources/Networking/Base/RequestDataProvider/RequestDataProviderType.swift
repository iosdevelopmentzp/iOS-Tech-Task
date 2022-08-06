//
//  RequestDataProviderType.swift
//  
//
//  Created by Dmytro Vorko on 05.08.2022.
//

import Foundation

protocol RequestDataProviderType {
    var host: String { get }
    
    var token: String? { get }
    
    var parameters: [String: Any]? { get }
    
    var headers: [String: String]? { get }
}
