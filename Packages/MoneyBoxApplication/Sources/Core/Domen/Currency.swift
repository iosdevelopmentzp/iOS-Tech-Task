//
//  Currency.swift
//  
//
//  Created by Dmytro Vorko on 25/10/2022.
//

import Foundation

public struct Currency: Hashable {
    // MARK: - Property
    
    public let value: Double
    public let sign: String
    
    // MARK: - Constructor
    
    public init(value: Double, sign: String) {
        self.value = value
        self.sign = sign
    }
}
